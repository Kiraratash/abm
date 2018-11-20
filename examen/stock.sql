CREATE TABLE ventas
        (id INT(8) NOT NULL AUTO_INCREMENT,
         id_frutas INT (8) NOT NULL, 
         fruta VARCHAR(30) NOT NULL,
         ventas INT(11) NOT NULL, 
         cantidad_vendida INT(11) NOT NULL,
         CONSTRAINT PK_venta PRIMARY KEY (id));

CREATE TABLE frutas 
        (id INT(8) NOT NULL AUTO_INCREMENT,
        nombre_fruta VARCHAR(30) NOT NULL ,
        precio INT(10) NOT NULL, 
        cantidad SMALLINT(11) NOT NULL, 
        CONSTRAINT PK_fruta PRIMARY KEY (id, nombre_fruta));


INSERT INTO frutas (nombre_fruta , precio , cantidad) VALUES  ('Tomates', 10, 10);

INSERT INTO frutas (nombre_fruta , precio , cantidad) VALUES  ('Banana', 5, 10);

INSERT INTO frutas (nombre_fruta , precio , cantidad) VALUES  ('Lechuga', 20, 10);


INSERT INTO frutas (nombre_fruta , precio , cantidad) VALUES  ('Manzana', 12, 10);



ALTER TABLE ventas ADD CONSTRAINT fk_id_frutas FOREIGN KEY (id_frutas , fruta) REFERENCES frutas(id, nombre_fruta);


alter table ventas drop foreign key fk_id_frutas;
