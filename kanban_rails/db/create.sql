drop database if exists kanban_development;
create database kanban_development;
drop database if exists kanban_test;
create database kanban_test;
drop database if exists kanban_production;
create database kanban_production;
GRANT ALL PRIVILEGES ON kanban_development.* TO 'kanban'@'localhost'
IDENTIFIED BY 'kanban' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON kanban_test.* TO 'kanban'@'localhost'
IDENTIFIED BY 'kanban' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON kanban_production.* TO 'kanban'@'localhost'
IDENTIFIED BY 'kanban' WITH GRANT OPTION;