import prisma from "../../client.js";
import type { Prisma, Table } from "@prisma/client";

export const TablesService = {
  list: async (): Promise<Table[]> => {
    return prisma.table.findMany({ orderBy: { id: "asc" } });
  },
  create: async (data: Prisma.TableUncheckedCreateInput): Promise<Table> => {
    return prisma.table.create({ data });
  },
};
