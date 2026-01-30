import { Router } from "express";
import { GuestGroupsController } from "../controllers/guest-groups.controller.js";

const router = Router();

router.get("/", GuestGroupsController.list);
router.post("/", GuestGroupsController.create);

export default router;
