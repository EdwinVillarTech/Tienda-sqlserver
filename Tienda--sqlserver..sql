CREATE DATABASE TiendaDB; 

USE TiendaDB;


CREATE TABLE Categorias (
     CategoriaID INT   IDENTITY(1,1) PRIMARY KEY,
     Nombre      VARCHAR (50)  NOT NULL,
     Descripcion VARCHAR (200) NULL

);


CREATE TABLE Productos (
       ProductoID  INT   IDENTITY(1,1) PRIMARY KEY,
       CategoriaID INT            NOT NULL,
       Nombre      VARCHAR (100)  NOT NULL,
       Precio      DECIMAL (10,2) NOT NULL,
       Stock       INT            NOT NULL DEFAULT 0,
       CONSTRAINT FK_Productos_Categorias
        FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)


);

CREATE TABLE Clientes (
ClienteID     INT           IDENTITY(1,1) PRIMARY KEY,
Nombre        VARCHAR (50)  NOT NULL, 
Apellido      VARCHAR (50)  NOT NULL,
Email         VARCHAR (100) NOT NULL UNIQUE,
Telefono      VARCHAR (20)  NULL,
FechaRegistro DATE          NOT NULL DEFAULT GETDATE ()
);



CREATE TABLE Pedidos (
       PedidoID    INT   IDENTITY (1,1) PRIMARY KEY, 
       ClienteID   INT   NOT NULL, 
       FechaPedido DATE  NOT NULL DEFAULT GETDATE (),
       Estado      VARCHAR(20) NOT NULL DEFAULT 'Pendiente',


       CONSTRAINT FK_Pedidos_Clientes
       FOREIGN KEY (ClienteID) 
       REFERENCES Clientes(ClienteID)

       );
       

       CREATE TABLE DetallePedidos (
       DetalleID       INT            IDENTITY(1,1) PRIMARY KEY,
       PedidoID        INT            NOT NULL,
       ProductoID      INT            NOT NULL,
       Cantidad        INT            NOT NULL,
       PrecioUnitario  DECIMAL (10,2) NOT NULL, 

       CONSTRAINT FK_Detalle_pedidos
       FOREIGN KEY (PedidoID) 
       REFERENCES Pedidos(PedidoID),

       CONSTRAINT FK_Detalle_Productos
       FOREIGN KEY (ProductoID)
       REFERENCES Productos (ProductoID)

       );



 INSERT INTO Categorias ( Nombre, Descripcion)
  VALUES  ('Electronica', 'Dispositivos Electronicos y Accesorios'),
          ('Ropa',        'Prendas de vestir paara hombre y mujer'),
          ('Hogar',       'Articulos para el hogar y decoracion'),
          ('Deportes',    'Equipos y ropa deportiva'),
          ('Libros',      'Libros y material educativo'),
          ('Alimentacion', 'Productos alimenticios y bebidas');



     

 INSERT INTO Productos (CategoriaID, Nombre, Precio, Stock)
   VALUES (1,  'Auriculares Bluetooth', 45.99, 80),
          (1,  'Cable USB-C',           8.50, 200),
          (1,  'Cargador Inalambrico',  29.99, 60),


 INSERT INTO Productos (CategoriaID, Nombre, Precio, Stock)
   VALUES (4, 'Pelota de Futbol',          22.00, 35),
          (4, 'Botella de Agua L1',        14.99, 120),
          (5, 'SQL Server Paso a Paso',    31.00, 30),
          (5, 'Introduccion a Python',     28.00, 25),
          (6, 'Cafe Molino 500g',          11.99, 60),
          (6, 'Chocolate Oscuro',         4.50, 100);

 
 

 INSERT INTO Clientes (Nombre, Apellido, Email, Telefono)
 VALUES ('Maria',   'Gonzales', 'Maria.gonzales@email.com',  '809-555-0101'),
        ('Carlos',  'Martinez', 'Carlos.martines@email.com', '809-555-0102'),
        ('Ana',     'Rodriguez','ana.rp=odriguez@emial.com', '809-555-0103'),
        ('Luis',    'Hernandez','luis.hernandez@email.com',  '809-555-0104'),
        ('Sofia',   'lopez',    'sofia.lopez@email.com',     '809-555-0105');



  
  INSERT INTO Pedidos (ClienteID, Estado)
  VALUES (1, 'Entregado'),
         (2, 'Entregado'),
         (3, 'Enviado'),
         (4, 'Procesando'),
         (5, 'Pendiente');






INSERT INTO DetallePedidos (PedidoID, ProductoID, Cantidad, PrecioUnitario)
VALUES  
      (1,1,1, 45.99),
      (1,2,2, 8.50),
      (2,3,3, 12.00),
      (3,4,1, 39.99),
      (4,5,1, 25.00),
      (5,6,2, 18.50);

    
SELECT 
       Cat.Nombre AS Categoria,
       Pr.Nombre  AS Producto,
       Pr.Precio,
       Pr.Stock

FROM Productos pr
     INNER JOIN Categorias cat 
ON   pr.CategoriaID = Cat.CategoriaID
ORDER BY Cat.Nombre;


SELECT 
     c.nombre + ' ' + c.Apellido AS Cliente,
     P.PedidoID,
     p.FechaPedido,
     p.Estado, 
     SUM(dp.Cantidad * dp.PrecioUnitario) AS Total
FROM Clientes c 
     INNER JOIN Pedidos p                 ON c.ClienteID = P.ClienteID
     INNER JOIN DetallePedidos dp         ON p.PedidoID  = dp.PedidoID
     GROUP BY
            C.Nombre, c.Apellido, p.PedidoID, p.FechaPedido, p.Estado
     ORDER BY p.PedidoID;




     SELECT TOP 3
           pr.Nombre              AS Producto,
           SUM(dp.Cantidad)       AS CantidadVendida
     FROM  Productos pr 
           INNER JOIN DetallePedidos dp on pr.ProductoID = dp.ProductoID
           GROUP BY pr.Nombre
           ORDER BY CantidadVendida ASC;



    SELECT

         c.Nombre + ' ' + c.Apellido               AS Cliente,
         COUNT(DISTINCT p.PedidoID)                AS TotalPedidos,
         SUM  (dp.Cantidad * dp.PrecioUnitario)    AS TotalGastado
    FROM Clientes c 
         INNER JOIN Pedidos p          on c.ClienteID = P.clienteID
         INNER JOIN DetallePedidos dp on p. PedidoID = dp.PedidoID
         GROUP BY c.Nombre, c.Apellido
         ORDER BY TotalGastado 
         DESC;


        