USE cab_booking;

-- One table for ALL logins: passenger, driver, admin, super admin.
-- The "role" column decides what each person is allowed to do.
CREATE TABLE users (
    user_id     INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(150) NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,   -- will store a HASH, never the real password
    mobile      VARCHAR(15)  NOT NULL,
    role        ENUM('PASSENGER','DRIVER','ADMIN','SUPER_ADMIN') NOT NULL,
    status      ENUM('ACTIVE','BLOCKED','PENDING') NOT NULL DEFAULT 'ACTIVE',
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Extra details only passengers have. One row per passenger user.
CREATE TABLE passenger_profiles (
    passenger_id       INT AUTO_INCREMENT PRIMARY KEY,
    user_id            INT NOT NULL UNIQUE,
    default_address    VARCHAR(255),
    emergency_contact  VARCHAR(15),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Extra details only drivers have. One row per driver user.
CREATE TABLE driver_profiles (
    driver_id            INT AUTO_INCREMENT PRIMARY KEY,
    user_id              INT NOT NULL UNIQUE,
    license_no           VARCHAR(50) NOT NULL UNIQUE,
    license_expiry       DATE NOT NULL,
    verification_status  ENUM('PENDING','APPROVED','REJECTED') NOT NULL DEFAULT 'PENDING',
    is_available         BOOLEAN NOT NULL DEFAULT FALSE,
    rating               DECIMAL(2,1) NOT NULL DEFAULT 0.0,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;
