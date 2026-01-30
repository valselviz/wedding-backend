import prisma from "../../client.js";
import type { TableAssignment } from "@prisma/client";

export type AssignTableInput = {
  tableId: number;
  guestId: number;
  seatNumber?: number | null;
};

export const TableAssignmentsService = {
  assign: async (input: AssignTableInput): Promise<TableAssignment> => {
    const { tableId, guestId, seatNumber } = input;

    const existingAssignment = await prisma.tableAssignment.findFirst({
      where: { table_id: tableId, guest_id: guestId },
    });

    if (existingAssignment) {
      throw new Error("Guest already assigned to this table");
    }

    if (seatNumber !== undefined && seatNumber !== null) {
      const [table, seatTaken] = await Promise.all([
        prisma.table.findUnique({ where: { id: tableId } }),
        prisma.tableAssignment.findFirst({
          where: { table_id: tableId, seat_number: seatNumber },
        }),
      ]);

      if (!table) {
        throw new Error("Table not found");
      }

      if (table.seats && seatNumber > table.seats) {
        throw new Error("Seat number exceeds table capacity");
      }

      if (seatTaken) {
        throw new Error("Seat number already taken");
      }
    }

    return prisma.tableAssignment.create({
      data: {
        table_id: tableId,
        guest_id: guestId,
        seat_number: seatNumber ?? null,
      },
    });
  },
};
