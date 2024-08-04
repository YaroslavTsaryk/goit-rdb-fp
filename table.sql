-- pandemic.infectious_cases definition

CREATE TABLE `infectious_cases` (
  `Year` int DEFAULT NULL,
  `Number_yaws` bigint DEFAULT NULL,
  `polio_cases` bigint DEFAULT NULL,
  `cases_guinea_worm` bigint DEFAULT NULL,
  `Number_rabies` double DEFAULT NULL,
  `Number_malaria` double DEFAULT NULL,
  `Number_hiv` double DEFAULT NULL,
  `Number_tuberculosis` double DEFAULT NULL,
  `Number_smallpox` bigint DEFAULT NULL,
  `Number_cholera_cases` bigint DEFAULT NULL,
  `entity_id` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `orig_year` date DEFAULT NULL,
  `current` date DEFAULT NULL,
  `ddiff` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `infectious_cases_entities_FK` (`entity_id`),
  CONSTRAINT `infectious_cases_entities_FK` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10522 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;