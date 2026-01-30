-- CreateEnum
CREATE TYPE "GuestType" AS ENUM ('MAIN_GUEST', 'PLUS_ONE', 'BRIDE', 'GROOM');

-- CreateEnum
CREATE TYPE "Side" AS ENUM ('BRIDE', 'GROOM');

-- CreateEnum
CREATE TYPE "AgeRange" AS ENUM ('ADULT', 'CHILD', 'BABY');

-- CreateEnum
CREATE TYPE "Status" AS ENUM ('INVITED', 'CONFIRMED', 'DECLINED');

-- CreateEnum
CREATE TYPE "Shape" AS ENUM ('redonda', 'rectangular');

-- CreateTable
CREATE TABLE "Guest" (
    "id" SERIAL NOT NULL,
    "full_name" VARCHAR(100) NOT NULL,
    "guest_type" "GuestType" NOT NULL,
    "main_guest_id" INTEGER,
    "side" "Side",
    "age_range" "AgeRange" NOT NULL DEFAULT 'ADULT',
    "notes" TEXT,
    "status" "Status" NOT NULL DEFAULT 'INVITED',

    CONSTRAINT "Guest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GuestGroup" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "category" VARCHAR(50),

    CONSTRAINT "GuestGroup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GuestGroupMember" (
    "id" SERIAL NOT NULL,
    "guest_id" INTEGER NOT NULL,
    "group_id" INTEGER NOT NULL,

    CONSTRAINT "GuestGroupMember_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Table" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "shape" "Shape",
    "seats" INTEGER NOT NULL,
    "category" VARCHAR(50),

    CONSTRAINT "Table_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TableAssignment" (
    "id" SERIAL NOT NULL,
    "table_id" INTEGER NOT NULL,
    "guest_id" INTEGER NOT NULL,
    "seat_number" INTEGER,

    CONSTRAINT "TableAssignment_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Guest" ADD CONSTRAINT "Guest_main_guest_id_fkey" FOREIGN KEY ("main_guest_id") REFERENCES "Guest"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "GuestGroupMember" ADD CONSTRAINT "GuestGroupMember_guest_id_fkey" FOREIGN KEY ("guest_id") REFERENCES "Guest"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "GuestGroupMember" ADD CONSTRAINT "GuestGroupMember_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "GuestGroup"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "TableAssignment" ADD CONSTRAINT "TableAssignment_table_id_fkey" FOREIGN KEY ("table_id") REFERENCES "Table"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "TableAssignment" ADD CONSTRAINT "TableAssignment_guest_id_fkey" FOREIGN KEY ("guest_id") REFERENCES "Guest"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
