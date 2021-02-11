CREATE DATABASE geek_taxi;

USE geek_taxi;

-- ТАБЛИЦЫ И ИНДЕКСЫ

DROP TABLE IF EXISTS ct_drivers;
CREATE TABLE ct_drivers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  last_name VARCHAR(255) NOT NULL COMMENT 'Фамилия водителя',
  first_name VARCHAR(255) NOT NULL COMMENT 'Имя водителя',
  middle_name VARCHAR(255) COMMENT 'Отчество водителя',
  work_city_id INT UNSIGNED COMMENT 'Ссылка на город, где работает водитель, таблица cat_city',
  birthday_at DATE COMMENT 'Дата рождения',
  passport_id INT UNSIGNED COMMENT 'Ссылка на паcпорт, таблица ct_driver_passport',
  insurance_id INT UNSIGNED COMMENT 'Ссылка на страховой полис, таблица ct_insurance',
  driving_license_id INT UNSIGNED COMMENT 'Ссылка на водительское удостоверение, таблица ct_driving_license',
  registration_address_id INT UNSIGNED COMMENT 'Адрес регистрации водителя, таблица ct_address',
  residence_address_id INT UNSIGNED COMMENT 'Адрес проживания водителя, таблица ct_address',
  driver_status_id INT UNSIGNED NOT NULL COMMENT 'Статус водителя в системе, таблица cat_driver_status',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Данные водителей';
CREATE index index_last_name on ct_drivers (last_name);
CREATE index index_first_name on ct_drivers (first_name);
CREATE index index_middle_name on ct_drivers (middle_name);
CREATE index index_passport_id on ct_drivers (passport_id);
CREATE index index_insurance_id on ct_drivers (insurance_id);
CREATE index index_driving_license_id on ct_drivers (driving_license_id);

DROP TABLE IF EXISTS ht_drivers;
CREATE TABLE ht_drivers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  driver_id INT UNSIGNED COMMENT 'Айди водителя, ссылка на таблицу ct_drivers',
  last_name VARCHAR(255) NOT NULL COMMENT 'Фамилия водителя',
  first_name VARCHAR(255) NOT NULL COMMENT 'Имя водителя',
  middle_name VARCHAR(255) COMMENT 'Отчество водителя',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Данные водителей';

DROP TABLE IF EXISTS ct_users;
CREATE TABLE ct_users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  last_name VARCHAR(255) COMMENT 'Фамилия пассажира',
  first_name VARCHAR(255) NOT NULL COMMENT 'Имя пассажира',
  middle_name VARCHAR(255) COMMENT 'Отчество пассажира',
  live_city_id INT UNSIGNED COMMENT 'Ссылка на город, где живет пассажир, таблица cat_city',
  birthday_at DATE COMMENT 'Дата рождения',
  registration_address_id INT UNSIGNED COMMENT 'Адрес регистрации пассажира, таблица ct_address',
  residence_address_id INT UNSIGNED COMMENT 'Адрес проживания пассажира, таблица ct_address',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Пассажиры';
CREATE index index_last_name on ct_users (last_name);
CREATE index index_first_name on ct_users (first_name);
CREATE index index_middle_name on ct_users (middle_name);
CREATE index index_live_city_id on ct_users (live_city_id);
CREATE index index_registration_address_id on ct_users (registration_address_id);
CREATE index index_residence_address_id on ct_users (residence_address_id);

DROP TABLE IF EXISTS cat_driver_status;
CREATE TABLE cat_driver_status (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  status VARCHAR(255) COMMENT 'Статус водителя',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Статус водителя';

DROP TABLE IF EXISTS ct_driver_passport;
CREATE TABLE ct_driver_passport (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  driver_id INT UNSIGNED COMMENT 'Айди водителя, ссылка на таблицу ct_drivers',
  passport_number VARCHAR(10) NOT NULL COMMENT 'Серия и номер паспорта водителя',
  release_date DATE COMMENT 'Дата выдачи паспорта водителя',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Данные паспорта';
CREATE unique index index_pass_number on ct_driver_passport (passport_number);

DROP TABLE IF EXISTS ht_driver_passport;
CREATE TABLE ht_driver_passport (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  driver_id INT UNSIGNED NOT NULL COMMENT 'Айди водителя, ссылка на таблицу ct_drivers',
  passport_number VARCHAR(10) NOT NULL COMMENT 'Серия и номер паспорта водителя',
  release_date DATE COMMENT 'Дата выдачи паспорта водителя',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Данные паспорта';

DROP TABLE IF EXISTS ct_driving_license;
CREATE TABLE ct_driving_license (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  driver_id INT UNSIGNED NOT NULL COMMENT 'Айди водителя, ссылка на таблицу ct_drivers',
  license_number INT NOT NULL COMMENT 'Номер водительского удостоверения',
  issue_date DATE COMMENT 'Дата выдачи',
  valid_until DATE COMMENT 'Действительно до',
  category VARCHAR(255) COMMENT 'Категории',
  active BOOL COMMENT 'Признак, что эти права сейчас действуют',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Данные водительского удостоверения';
CREATE unique index index_driving_license on ct_driving_license (license_number);
CREATE index index_issue_date on ct_driving_license (issue_date);
CREATE index index_valid_until on ct_driving_license (valid_until);

DROP TABLE IF EXISTS ht_driving_license;
CREATE TABLE ht_driving_license (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  driver_id INT UNSIGNED NOT NULL COMMENT 'Айди водителя, ссылка на таблицу ct_drivers',
  license_number INT NOT NULL COMMENT 'Номер водительского удостоверения',
  issue_date DATE COMMENT 'Дата выдачи',
  valid_until DATE COMMENT 'Действительно до',
  category VARCHAR(255) COMMENT 'Категории',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Данные водительского удостоверения';

DROP TABLE IF EXISTS ct_insurance;
CREATE TABLE ct_insurance (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  driver_id INT UNSIGNED NOT NULL COMMENT 'Айди водителя, ссылка на таблицу ct_drivers',
  insurance_number VARCHAR(255) NOT NULL COMMENT 'Серия и номер',
  issue_date DATE NOT NULL COMMENT 'Дата выдачи',
  valid_until DATE NOT NULL COMMENT 'Действительно до',
  active BOOL COMMENT 'Признак, что этот полис сейчас действует',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Данные страхового полиса';
CREATE unique index index_insurance_number on ct_insurance (insurance_number);
CREATE index index_issue_date on ct_insurance (issue_date);
CREATE index index_valid_until on ct_insurance (valid_until);

DROP TABLE IF EXISTS ht_insurance;
CREATE TABLE ht_insurance (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  driver_id INT UNSIGNED NOT NULL COMMENT 'Айди водителя, ссылка на таблицу ct_drivers',
  insurance_number VARCHAR(255) NOT NULL COMMENT 'Серия и номер',
  issue_date DATE NOT NULL COMMENT 'Дата выдачи',
  valid_until DATE NOT NULL COMMENT 'Действительно до',
  active BOOL COMMENT 'Признак, что этот полис сейчас действует',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Данные страхового полиса';

DROP TABLE IF EXISTS ct_cars;
CREATE TABLE ct_cars (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  driver_id INT UNSIGNED NOT NULL COMMENT 'Айди водителя, ссылка на таблицу ct_drivers',
  car_brand VARCHAR(255) COMMENT 'Марка машины',
  car_model VARCHAR(255) COMMENT 'Модель машины',
  car_color VARCHAR(255) COMMENT 'Цвет машины',
  production_date VARCHAR(255) COMMENT 'Дата производства',
  gos_number VARCHAR(255) COMMENT 'Гос номер машины',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Данные машин';
CREATE index index_driver_id on ct_cars (driver_id);
CREATE index index_car_brand on ct_cars (car_brand);
CREATE index index_car_model on ct_cars (car_model);
	
DROP TABLE IF EXISTS cat_city;
CREATE TABLE cat_city (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  city_name VARCHAR(255) COMMENT 'Название города',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Город';
CREATE index index_city_name on cat_city (city_name);

DROP TABLE IF EXISTS ct_address;
CREATE TABLE ct_address (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  city_id INT UNSIGNED COMMENT 'Ссылка на таблицу cat_city',
  street VARCHAR(255) COMMENT 'Улица',
  house_number VARCHAR(255) COMMENT 'Номер дома, включая литеры',
  entrance_number VARCHAR(255) COMMENT 'Номер подъезда',
  apartment_number VARCHAR(255) COMMENT 'Номер квартиры',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Адреса пользователей и водителей';
CREATE index index_city_id on ct_address (city_id);
CREATE index index_street on ct_address (street);
CREATE index index_house_number on ct_address (house_number);

DROP TABLE IF EXISTS cat_ratings;
CREATE TABLE cat_ratings (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  rating VARCHAR(255) COMMENT 'Рейтинг от 1 (мин) до 10 (макс)',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Рейтинги';

DROP TABLE IF EXISTS ct_messages;
CREATE TABLE ct_messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED COMMENT 'Айди клиента, ссылка на таблицу ct_users',
  driver_id INT UNSIGNED COMMENT 'Айди водителя, ссылка на таблицу ct_drivers',
  flag_user_to_driver BOOL COMMENT 'Сообщение написано клиентом водителю',
  flag_driver_to_user BOOL COMMENT 'Сообщение написано водителем клиенту',
  body TEXT COMMENT 'Текст сообщения',
  is_delivered BOOL COMMENT 'Признак доставки',
  is_read BOOL COMMENT 'Признак прочтения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Сообщения между водителем и клиентом';
CREATE index index_user_id on ct_messages (user_id);
CREATE index index_driver_id on ct_messages (driver_id);

DROP TABLE IF EXISTS ct_comments;
CREATE TABLE ct_comments (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED COMMENT 'Айди клиента, ссылка на таблицу ct_users',
  driver_id INT UNSIGNED COMMENT 'Айди водителя, ссылка на таблицу ct_drivers',
  flag_user_to_driver BOOL COMMENT 'Комментарий написан клиентом о водителе',
  flag_driver_to_user BOOL COMMENT 'Комментарий написан водителем о клиенте',
  body TEXT COMMENT 'Текст комментария',
  is_posted BOOL COMMENT 'Признак успешного размещения комментарий',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Комментарии о водителях и пользователях';
CREATE index index_user_id on ct_comments (user_id);
CREATE index index_driver_id on ct_comments (driver_id);
	
DROP TABLE IF EXISTS ct_trips;
CREATE TABLE ct_trips (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_id INT UNSIGNED COMMENT 'Ссылка на таблицу ct_orders',
  date_trip DATETIME COMMENT 'Дата и время начала поездки',
  driver_id INT UNSIGNED COMMENT 'Айди водителя, ссылка на таблицу ct_drivers', 
  user_id INT UNSIGNED COMMENT 'Айди клиента, ссылка на таблицу ct_users',
  addr_from_id INT UNSIGNED COMMENT 'Адрес, откуда забирать, ссылка на таблицу ct_address', 
  addr_to_id INT UNSIGNED COMMENT 'Адрес назначения, ссылка на таблицу ct_address', 
  time_for_wait TIME COMMENT 'Время ожиданиея',
  time_for_trip TIME COMMENT 'Время поездки',
  distance_trip INT COMMENT 'Дальность поездки, км',
  cost_trip INT COMMENT 'Стоимость поездки, руб.',
  driver_rating_id INT UNSIGNED COMMENT 'Рейтинг водителя, проставляется пользователем. Ссылка на таблицу cat_ratings',
  user_rating_id INT UNSIGNED COMMENT 'Рейтинг пользователя, проставляется водителем. Ссылка на таблицу cat_ratings',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Данные о поездках';
CREATE index index_order_id on ct_trips (order_id);
CREATE index index_driver_id on ct_trips (driver_id);
CREATE index index_user_id on ct_trips (user_id);
CREATE index index_addr_from_id on ct_trips (addr_from_id);
CREATE index index_addr_to_id on ct_trips (addr_to_id);		

DROP TABLE IF EXISTS ct_orders;
CREATE TABLE ct_orders (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED COMMENT 'Айди клиента, ссылка на таблицу ct_users',
  addr_from_id INT UNSIGNED COMMENT 'Адрес, откуда забирать, ссылка на таблицу ct_address',
  addr_to_id INT UNSIGNED COMMENT 'Адрес назначения, ссылка на таблицу ct_address',
  cost_trip INT COMMENT 'Стоимость поездки',
  user_comment TEXT COMMENT 'Комментарий к заказу',
  date_order DATETIME COMMENT 'Дата и время начала заказа',
  order_is_done BOOL COMMENT 'Признак, выполнен заказ или нет', 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Данные о заказах';
CREATE index index_user_id on ct_orders (user_id);
CREATE index index_addr_from_id on ct_orders (addr_from_id);
CREATE index index_addr_to_id on ct_orders (addr_to_id);


-- ВНЕШНИЕ КЛЮЧИ

ALTER table ct_drivers
	ADD CONSTRAINT ct_drivers_work_city_id_fk
		FOREIGN KEY (work_city_id) REFERENCES cat_city(id),
	ADD CONSTRAINT ct_drivers_passport_id_fk
		FOREIGN KEY (passport_id) REFERENCES ct_driver_passport(id),
	ADD CONSTRAINT ct_drivers_insurance_id_fk
		FOREIGN KEY (insurance_id) REFERENCES ct_insurance(id),
	ADD CONSTRAINT ct_drivers_driving_license_id_fk
		FOREIGN KEY (driving_license_id) REFERENCES ct_driving_license(id),
	ADD CONSTRAINT ct_drivers_registration_address_id_fk
		FOREIGN KEY (registration_address_id) REFERENCES ct_address(id),
	ADD CONSTRAINT ct_drivers_residence_address_id_fk
		FOREIGN KEY (residence_address_id) REFERENCES ct_address(id),
	ADD CONSTRAINT ct_drivers_driver_status_id_fk
		FOREIGN KEY (driver_status_id) REFERENCES cat_driver_status(id);

ALTER table ct_users
	ADD CONSTRAINT ct_users_live_city_id_fk
		FOREIGN KEY (live_city_id) REFERENCES cat_city(id),
	ADD CONSTRAINT ct_users_registration_address_id_fk
		FOREIGN KEY (registration_address_id) REFERENCES ct_address(id),
	ADD CONSTRAINT ct_users_residence_address_id_fk
		FOREIGN KEY (residence_address_id) REFERENCES ct_address(id);
	
ALTER table ct_driver_passport 
	ADD CONSTRAINT ct_driver_passport_driver_id_fk
		FOREIGN KEY (driver_id) REFERENCES ct_drivers(id);

ALTER table ct_driving_license 
	ADD CONSTRAINT ct_driving_license_driver_id_fk
		FOREIGN KEY (driver_id) REFERENCES ct_drivers(id);

ALTER table ct_insurance 
	ADD CONSTRAINT ct_insurance_driver_id_fk
		FOREIGN KEY (driver_id) REFERENCES ct_drivers(id);
	
ALTER table ct_cars
	ADD CONSTRAINT ct_cars_driver_id_fk
		FOREIGN KEY (driver_id) REFERENCES ct_drivers(id);
	
ALTER table ct_address
	ADD CONSTRAINT ct_address_city_id_fk
		FOREIGN KEY (city_id) REFERENCES cat_city(id);

ALTER table ct_comments
	ADD CONSTRAINT ct_comments_user_id_fk
		FOREIGN KEY (user_id) REFERENCES ct_users(id),
	ADD CONSTRAINT ct_comments_driver_id_fk
		FOREIGN KEY (driver_id) REFERENCES ct_drivers(id);
	
ALTER table ct_messages
	ADD CONSTRAINT ct_messages_user_id_fk
		FOREIGN KEY (user_id) REFERENCES ct_users(id),
	ADD CONSTRAINT ct_messages_driver_id_fk
		FOREIGN KEY (driver_id) REFERENCES ct_drivers(id);

ALTER table ct_trips
	ADD CONSTRAINT ct_trips_order_id_fk
		FOREIGN KEY (order_id) REFERENCES ct_orders(id),
	ADD CONSTRAINT ct_trips_driver_id_fk
		FOREIGN KEY (driver_id) REFERENCES ct_drivers(id),
	ADD CONSTRAINT ct_trips_user_id_fk
		FOREIGN KEY (user_id) REFERENCES ct_users(id),
	ADD CONSTRAINT ct_trips_addr_from_id_fk
		FOREIGN KEY (addr_from_id) REFERENCES ct_address(id),
	ADD CONSTRAINT ct_trips_addr_to_id_fk
		FOREIGN KEY (addr_to_id) REFERENCES ct_address(id),
	ADD CONSTRAINT ct_trips_driver_rating_id_fk
		FOREIGN KEY (driver_rating_id) REFERENCES cat_ratings(id),
	ADD CONSTRAINT ct_trips_user_rating_id_fk
		FOREIGN KEY (user_rating_id) REFERENCES cat_ratings(id);	
	
ALTER table ct_orders
	ADD CONSTRAINT ct_orders_user_id_fk
		FOREIGN KEY (user_id) REFERENCES ct_users(id),
	ADD CONSTRAINT ct_orders_addr_from_id_fk
		FOREIGN KEY (addr_from_id) REFERENCES ct_address(id),
	ADD CONSTRAINT ct_orders_addr_to_id_fk
		FOREIGN KEY (addr_to_id) REFERENCES ct_address(id);
		

-- ТРИГГЕРЫ
	
DROP TRIGGER IF EXISTS driver_passport_update;
DELIMITER //
CREATE TRIGGER driver_passport_update AFTER UPDATE ON ct_driver_passport 
FOR EACH ROW
BEGIN
	IF NEW.passport_number != OLD.passport_number 
		OR NEW.release_date != OLD.release_date THEN 
			insert into ht_driver_passport(driver_id, passport_number, release_date, created_at)
			VALUES (old.driver_id, old.passport_number, old.release_date, old.created_at);
	END IF;
END//
DELIMITER ;

DROP TRIGGER IF EXISTS driver_fio_update;
DELIMITER //
CREATE TRIGGER driver_fio_update AFTER UPDATE ON ct_drivers
FOR EACH ROW
BEGIN
	IF NEW.last_name != OLD.last_name 
		OR NEW.first_name != OLD.first_name 
		OR NEW.middle_name != OLD.middle_name THEN 
			insert into ht_drivers(driver_id, last_name, first_name, middle_name, created_at)
			VALUES (old.id, old.last_name, old.first_name, old.middle_name, old.created_at);
	END IF;
END//
DELIMITER ;

DROP TRIGGER IF EXISTS driving_license_update;
DELIMITER //
CREATE TRIGGER driving_license_update AFTER UPDATE ON ct_driving_license
FOR EACH ROW
BEGIN
	IF NEW.license_number != OLD.license_number 
		OR NEW.issue_date != OLD.issue_date  
		OR NEW.valid_until != OLD.valid_until 
		OR NEW.category != OLD.category  THEN 
			insert ht_driver_passport(driver_id, license_number, issue_date, valid_until, category, created_at)
			VALUES (old.driver_id, old.license_number, old.issue_date, old.valid_until, old.category, old.created_at);
	END IF;
END//
DELIMITER ;

DROP TRIGGER IF EXISTS insurance_update;
DELIMITER //
CREATE TRIGGER insurance_update_update AFTER UPDATE ON ct_insurance
FOR EACH ROW
BEGIN
	IF NEW.insurance_number != OLD.insurance_number 
		OR NEW.issue_date != OLD.issue_date  
		OR NEW.valid_until != OLD.valid_until THEN 
			insert ht_driver_passport(driver_id, insurance_number, issue_date, valid_until, created_at)
			VALUES (old.driver_id, old.insurance_number, old.issue_date, old.valid_until, old.created_at);
	END IF;
END//
DELIMITER ;


-- ПРЕДСТАВЛЕНИЯ
-- DROP VIEW IF EXISTS driver_trips;
-- -- CREATE VIEW driver_trips AS 
SELECT 
di.id,
di.last_name,
di.first_name,
di.middle_name,
city.city_name,
SUM(trip.distance_trip) as total_trip
FROM ct_drivers di
left join cat_city city on city.id = di.work_city_id
left join ct_trips trip on trip.driver_id = di.id
GROUP BY
di.id,
di.last_name,
di.first_name,
di.middle_name,
city.city_name
ORDER BY total_trip DESC;



