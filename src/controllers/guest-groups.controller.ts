import type { Request, Response } from "express";
import { GuestGroupsService } from "../services/guest-groups/guest-groups.service.js";

export const GuestGroupsController = {
  list: async (_req: Request, res: Response) => {
    try {
      const groups = await GuestGroupsService.list();
      res.json(groups);
    } catch (error) {
      res.status(500).json({ error: "Failed to list groups" });
    }
  },
  create: async (req: Request, res: Response) => {
    try {
      const payload = req.body ?? {};
      const group = await GuestGroupsService.create({
        name: payload.name,
        category: payload.category ?? null,
      });

      res.status(201).json(group);
    } catch (error) {
      res.status(400).json({ error: "Failed to create group" });
    }
  },
};
