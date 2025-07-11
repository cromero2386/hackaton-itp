-- Tabla de categorías
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- Tabla de productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    imagen VARCHAR(255),
    categoria_id INT,
    creado_en DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Tabla de carritos
CREATE TABLE carritos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    creado_en DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Relación de productos en el carrito
CREATE TABLE carrito_productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    carrito_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    agregado_en DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (carrito_id) REFERENCES carritos(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Tabla de órdenes
CREATE TABLE ordenes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    carrito_id INT,
    total DECIMAL(10,2) NOT NULL,
    estado VARCHAR(50) DEFAULT 'pendiente',
    creado_en DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (carrito_id) REFERENCES carritos(id)
);

-- Relación de productos en la orden (histórico)
CREATE TABLE orden_productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orden_id INT NOT NULL,
    producto_id INT NOT NULL,
    nombre_producto VARCHAR(100),
    precio DECIMAL(10,2),
    cantidad INT NOT NULL DEFAULT 1,
    FOREIGN KEY (orden_id) REFERENCES ordenes(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Datasets
-- Categorías
INSERT INTO categorias (nombre, descripcion) VALUES
('Entradas', 'Aperturas ligeras para comenzar la comida'),
('Platos principales', 'Comidas fuertes y sustanciosas'),
('Postres', 'Opciones dulces para finalizar la comida'),
('Bebidas', 'Bebidas frías y calientes');

-- Productos (comidas)
INSERT INTO productos (nombre, descripcion, precio, imagen, categoria_id) VALUES
('Ensalada César', 'Lechuga, crutones, queso parmesano y aderezo César', 8.50, 'https://via.placeholder.com/150', 1),
('Empanadas de Carne', 'Empanadas rellenas de carne especiada', 6.00, 'https://via.placeholder.com/150', 1),
('Milanesa con Papas', 'Milanesa de res con guarnición de papas fritas', 15.50, 'https://via.placeholder.com/150', 2),
('Spaghetti Bolognesa', 'Pasta con salsa bolognesa y queso rallado', 13.00, 'https://via.placeholder.com/150', 2),
('Helado Artesanal', 'Helado casero de vainilla y chocolate', 5.00, 'https://via.placeholder.com/150', 3),
('Tarta de Manzana', 'Tarta casera de manzana con canela', 5.50, 'https://via.placeholder.com/150', 3),
('Agua Mineral', 'Botella de agua mineral 500ml', 2.00, 'https://via.placeholder.com/150', 4),
('Jugo de Naranja', 'Jugo natural de naranja exprimida', 3.50, 'https://via.placeholder.com/150', 4);

-- Carritos
INSERT INTO carritos (usuario_id) VALUES
(1),
(2);

-- Carrito_productos
INSERT INTO carrito_productos (carrito_id, producto_id, cantidad) VALUES
(1, 1, 1), -- 1 Ensalada César en el carrito 1
(1, 3, 2), -- 2 Milanesas con Papas en el carrito 1
(1, 7, 2), -- 2 Agua Mineral en el carrito 1
(2, 2, 2), -- 2 Empanadas de Carne en el carrito 2
(2, 4, 1), -- 1 Spaghetti Bolognesa en el carrito 2
(2, 8, 1); -- 1 Jugo de Naranja en el carrito 2

-- Ordenes
INSERT INTO ordenes (usuario_id, carrito_id, total, estado) VALUES
(1, 1, 43.00, 'completada'),
(2, 2, 25.00, 'pendiente');

-- Orden_productos
INSERT INTO orden_productos (orden_id, producto_id, nombre_producto, precio, cantidad) VALUES
(1, 1, 'Ensalada César', 8.50, 1),
(1, 3, 'Milanesa con Papas', 15.50, 2),
(1, 7, 'Agua Mineral', 2.00, 2),
(2, 2, 'Empanadas de Carne', 6.00, 2),
(2, 4, 'Spaghetti Bolognesa', 13.00, 1),
(2, 8, 'Jugo de Naranja', 3.50, 1);