CREATE RULE AgeRule
AS
    CHECK (age BETWEEN 18 AND 100);

EXEC sp_bindrule 'AgeRule', 'Employees.Age';

EXEC sp_unbindrule 'AgeRule', 'Employees.Age';

DROP RULE rule_name;
