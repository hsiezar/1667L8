CREATE SEQUENCE part_number_seq START WITH 50000;

CREATE OR REPLACE FUNCTION add_part() RETURNS "trigger"  AS 
$BODY$
BEGIN
NEW.part_number := nextval('part_number_seq');
RETURN NEW;
END ;
$BODY$
LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER mytrig 
BEFORE INSERT ON part_nyc 
FOR EACH ROW
EXECUTE PROCEDURE add_part();
