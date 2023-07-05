CREATE TABLE "public.Кабинет" (
	"ID_кабинета" integer(3) NOT NULL,
	"№ кабинета" integer(3) NOT NULL UNIQUE,
	"Этаж" integer(2) NOT NULL,
	"Предмет" VARCHAR(20) NOT NULL,
	"Вместимость" integer(2) NOT NULL,
	CONSTRAINT "Кабинет_pk" PRIMARY KEY ("ID_кабинета")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Классы" (
	"ID_класса (3а, 4б и пр.)" VARCHAR(2) NOT NULL,
	"Год образования" integer(4) NOT NULL,
	"Год обучения" integer(2) NOT NULL,
	"Литера класса" VARCHAR(1) NOT NULL,
	"Классный руководитель" integer(4) NOT NULL UNIQUE,
	"Примечание" TEXT NOT NULL,
	CONSTRAINT "Классы_pk" PRIMARY KEY ("ID_класса (3а, 4б и пр.)")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Ученики" (
	"ID_ученика" serial(6) NOT NULL,
	"Класс" VARCHAR(255) NOT NULL,
	"ФИО" VARCHAR(100) NOT NULL,
	"Дата рождения" DATE(8) NOT NULL,
	"Тел. представителя - 1" VARCHAR(15) NOT NULL,
	"Тел.представителя - 2" VARCHAR(15) NOT NULL,
	"Статус" VARCHAR(20) NOT NULL,
	CONSTRAINT "Ученики_pk" PRIMARY KEY ("ID_ученика")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Обучение в кабинетах" (
	"Кабинет" integer NOT NULL,
	"Начало урока" DATETIME(14) NOT NULL,
	"Окончание урока" DATETIME(14) NOT NULL,
	"Ученик" integer(6) NOT NULL,
	"Назначенный преподаватель" integer NOT NULL,
	"Ряд" integer(2) NOT NULL,
	"Парта (№, вариант)" VARCHAR(7) NOT NULL,
	"Примечание" TEXT NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Преподаватели" (
	"ID_Преподавателя" serial(5) NOT NULL,
	"ФИО преподавателя" VARCHAR(100) NOT NULL,
	"Основной предмет" integer(3) NOT NULL,
	"Квалиф. категория" VARCHAR(255) NOT NULL,
	"Тел. рабочий" VARCHAR(15) NOT NULL,
	"Тел. личный" VARCHAR(15) NOT NULL,
	CONSTRAINT "Преподаватели_pk" PRIMARY KEY ("ID_Преподавателя")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Школьные предметы" (
	"ID_предмета" serial(3) NOT NULL,
	"Наименование" VARCHAR(50) NOT NULL UNIQUE,
	"Год начала изучения" integer(2) NOT NULL,
	"Число преподавателей" integer(2) NOT NULL,
	CONSTRAINT "Школьные предметы_pk" PRIMARY KEY ("ID_предмета")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Назначения по предметам" (
	"ID_назначение" serial(10) NOT NULL,
	"Дата назначения" DATE(8) NOT NULL,
	"Преподаватель" integer NOT NULL,
	"Предмет" integer NOT NULL,
	"Примечание" TEXT NOT NULL,
	CONSTRAINT "Назначения по предметам_pk" PRIMARY KEY ("ID_назначение")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Замены" (
	"Дата-время обучения" DATETIME(14) NOT NULL,
	"Назначение исходное" integer NOT NULL,
	"Назначение замены" integer NOT NULL
) WITH (
  OIDS=FALSE
);



ALTER TABLE "Кабинет" ADD CONSTRAINT "Кабинет_fk0" FOREIGN KEY ("Предмет") REFERENCES "Школьные предметы"("ID_предмета");

ALTER TABLE "Классы" ADD CONSTRAINT "Классы_fk0" FOREIGN KEY ("Классный руководитель") REFERENCES "Преподаватели"("ID_Преподавателя");

ALTER TABLE "Ученики" ADD CONSTRAINT "Ученики_fk0" FOREIGN KEY ("Класс") REFERENCES "Классы"("ID_класса (3а, 4б и пр.)");

ALTER TABLE "Обучение в кабинетах" ADD CONSTRAINT "Обучение в кабинетах_fk0" FOREIGN KEY ("Кабинет") REFERENCES "Кабинет"("ID_кабинета");
ALTER TABLE "Обучение в кабинетах" ADD CONSTRAINT "Обучение в кабинетах_fk1" FOREIGN KEY ("Ученик") REFERENCES "Ученики"("ID_ученика");
ALTER TABLE "Обучение в кабинетах" ADD CONSTRAINT "Обучение в кабинетах_fk2" FOREIGN KEY ("Назначенный преподаватель") REFERENCES "Назначения по предметам"("ID_назначение");


ALTER TABLE "Назначения по предметам" ADD CONSTRAINT "Назначения по предметам_fk0" FOREIGN KEY ("Преподаватель") REFERENCES "Преподаватели"("ID_Преподавателя");
ALTER TABLE "Назначения по предметам" ADD CONSTRAINT "Назначения по предметам_fk1" FOREIGN KEY ("Предмет") REFERENCES "Школьные предметы"("ID_предмета");

ALTER TABLE "Замены" ADD CONSTRAINT "Замены_fk0" FOREIGN KEY ("Назначение исходное") REFERENCES "Назначения по предметам"("ID_назначение");
ALTER TABLE "Замены" ADD CONSTRAINT "Замены_fk1" FOREIGN KEY ("Назначение замены") REFERENCES "Назначения по предметам"("ID_назначение");









