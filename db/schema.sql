CREATE DATABASE IF NOT EXISTS planner_db;
USE planner_db;

-- Team table
CREATE TABLE IF NOT EXISTS teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- Employees table (formerly team_members)
CREATE TABLE IF NOT EXISTS employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    position VARCHAR(100),
    manager_id INT DEFAULT NULL,
    team_id INT DEFAULT NULL,
    status ENUM('active', 'vacation', 'inactive') DEFAULT 'active',
    profile TEXT,
    FOREIGN KEY (manager_id) REFERENCES employees(id),
    FOREIGN KEY (team_id) REFERENCES teams(id)
) ENGINE=InnoDB;

-- Projects table
CREATE TABLE IF NOT EXISTS projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    manager_id INT DEFAULT NULL,
    team_id INT DEFAULT NULL,
    duration INT,
    status ENUM('unassigned', 'ongoing', 'finished') DEFAULT 'unassigned',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (manager_id) REFERENCES employees(id),
    FOREIGN KEY (team_id) REFERENCES teams(id)
) ENGINE=InnoDB;

-- Tasks table
CREATE TABLE IF NOT EXISTS tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    employee_id INT DEFAULT NULL,
    manager_id INT DEFAULT NULL,
    team_id INT DEFAULT NULL,
    duration INT,
    status ENUM('unassigned', 'ongoing', 'finished') DEFAULT 'unassigned',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employees(id),
    FOREIGN KEY (manager_id) REFERENCES employees(id),
    FOREIGN KEY (team_id) REFERENCES teams(id)
) ENGINE=InnoDB;

INSERT INTO teams (name) VALUES 
('Development Team 1'),
('Development Team 2');

-- Insert employees
INSERT INTO employees (name, email, position, manager_id, team_id, status, profile) VALUES
('Ahmed Al-Kuwari', 'ahmed@qatardev.com', 'Frontend Developer', NULL, 1, 'active', 'Frontend specialist based in Doha.'),
('Sara Al-Mannai', 'sara@qatardev.com', 'Backend Developer', NULL, 1, 'active', 'Backend and infrastructure expert in Qatar.'),
('Khalid Al-Sulaiti', 'khalid@qatarmanagement.com', 'Project Manager', NULL, 2, 'active', 'Oversees Qatar-based software initiatives.'),
('Fatima Al-Naimi', 'fatima@qatarmanagement.com', 'Team Lead', 3, 2, 'active', 'Leads QA and integration efforts in Qatar.');

-- Update manager relationships
UPDATE employees SET manager_id = 3 WHERE id = 1 OR id = 2;

-- Insert projects
INSERT INTO projects (title, description, start_date, end_date, manager_id, team_id, duration, status) VALUES
('Qatar Inventory System', 'Build an inventory management system for logistics operations in Doha.', '2025-05-01', '2025-07-01', 3, 1, 60, 'ongoing'),
('Qatar Website Revamp', 'Modernize the government services portal.', '2025-05-10', '2025-06-30', 4, 2, 50, 'unassigned');

-- Insert tasks for "Qatar Inventory System"
INSERT INTO tasks (project_id, title, description, start_date, end_date, employee_id, manager_id, team_id, duration, status) VALUES
(1, 'Setup project structure', 'Initialize Git repo, setup CI/CD for Qatar deployment.', '2025-05-01', '2025-05-03', 1, 3, 1, 2, 'finished'),
(1, 'Design DB schema', 'Design relational schema for logistics inventory.', '2025-05-04', '2025-05-10', 2, 4, 1, 6, 'ongoing'),
(1, 'Develop frontend UI', 'Build the web interface in Arabic and English.', '2025-05-11', '2025-05-20', 1, 4, 1, 9, 'unassigned');
