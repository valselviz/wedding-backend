import prisma from "../../client.js";
import type { GuestGroup, Prisma } from "@prisma/client";

export const GuestGroupsService = {
  list: async (): Promise<GuestGroup[]> => {
    return prisma.guestGroup.findMany({ orderBy: { id: "asc" } });
  },
  create: async (
    data: Prisma.GuestGroupUncheckedCreateInput,
  ): Promise<GuestGroup> => {
    return prisma.guestGroup.create({ data });
  },
};
