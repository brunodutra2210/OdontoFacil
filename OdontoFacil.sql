CREATE TABLE "public.tb_usuario" (
	"id" serial NOT NULL,
	"nome" varchar(255),
	"email" varchar(255) UNIQUE,
	"senha" TEXT(32),
	"dt_nascimento" DATE,
	"admin" BOOLEAN DEFAULT 'false',
	"avatar" TEXT,
	"criado" DATETIME,
	"alterado" DATETIME NOT NULL,
	CONSTRAINT "tb_usuario_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.tb_servico" (
	"id" serial,
	"id_empresa" integer UNIQUE,
	"nome" varchar(255) UNIQUE,
	"duracao" DATETIME NOT NULL UNIQUE,
	"preco" DECIMAL,
	"criado" DATETIME,
	"alterado" DATETIME,
	CONSTRAINT "tb_servico_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.tb_profissional_servico" (
	"id_profissional" integer,
	"id_servico" integer,
	CONSTRAINT "tb_profissional_servico_pk" PRIMARY KEY ("id_profissional","id_servico")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.tb_empresa" (
	"id" serial NOT NULL,
	"nome" varchar(255) UNIQUE,
	"logo" TEXT,
	"slot" TIME DEFAULT '00:30:00',
	"id_endereco" integer NOT NULL,
	CONSTRAINT "tb_empresa_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.tb_endereco" (
	"id" serial NOT NULL,
	"rua" varchar(255),
	"numero" varchar(10),
	"bairro" varchar(255),
	"cidade" varchar(255),
	"estado" VARCHAR(2),
	"cep" varchar(9),
	CONSTRAINT "tb_endereco_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.tb_agenda" (
	"id" serial NOT NULL,
	"id_profissional" integer NOT NULL,
	"id_servico" integer NOT NULL,
	"id_cliente" integer NOT NULL,
	"horario" DATETIME NOT NULL,
	CONSTRAINT "tb_agenda_pk" PRIMARY KEY ("id","id_profissional","id_cliente")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.tb_horario" (
	"id" serial NOT NULL,
	"inicio" TIME,
	"inicio_intervalo" TIME,
	"final_intervalo" TIME,
	"final" TIME,
	"dia" integer UNIQUE,
	"id_empresa" integer UNIQUE,
	CONSTRAINT "tb_horario_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);




ALTER TABLE "tb_servico" ADD CONSTRAINT "tb_servico_fk0" FOREIGN KEY ("id_empresa") REFERENCES "tb_empresa"("id");

ALTER TABLE "tb_profissional_servico" ADD CONSTRAINT "tb_profissional_servico_fk0" FOREIGN KEY ("id_profissional") REFERENCES "tb_usuario"("id");
ALTER TABLE "tb_profissional_servico" ADD CONSTRAINT "tb_profissional_servico_fk1" FOREIGN KEY ("id_servico") REFERENCES "tb_servico"("id");

ALTER TABLE "tb_empresa" ADD CONSTRAINT "tb_empresa_fk0" FOREIGN KEY ("id_endereco") REFERENCES "tb_endereco"("id");


ALTER TABLE "tb_agenda" ADD CONSTRAINT "tb_agenda_fk0" FOREIGN KEY ("id_profissional") REFERENCES "tb_usuario"("id");
ALTER TABLE "tb_agenda" ADD CONSTRAINT "tb_agenda_fk1" FOREIGN KEY ("id_servico") REFERENCES "tb_servico"("id");
ALTER TABLE "tb_agenda" ADD CONSTRAINT "tb_agenda_fk2" FOREIGN KEY ("id_cliente") REFERENCES "tb_usuario"("id");

ALTER TABLE "tb_horario" ADD CONSTRAINT "tb_horario_fk0" FOREIGN KEY ("id_empresa") REFERENCES "tb_empresa"("id");
