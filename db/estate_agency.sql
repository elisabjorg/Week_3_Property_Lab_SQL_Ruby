DROP TABLE IF EXISTS estate_agency;

CREATE TABLE estate_agency (
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT8,
  number_of_bedrooms INT8,
  year_built INT8
);
