CREATE TABLE users(
    user_id int not null PRIMARY KEY,
    user_name VARCHAR(20) not NULL,
    user_age int CHECK(user_age > 18)
)