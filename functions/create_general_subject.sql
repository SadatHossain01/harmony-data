CREATE OR REPLACE FUNCTION create_general_subject() RETURNS TRIGGER AS $cgs$
    begin
	    raise notice 'group id: %', new.group_id;
	    INSERT INTO "Subject" (subject_name, parent_group_id) 
	    	values ('General', new.group_id);
        RETURN NULL; 
    END;
$cgs$ LANGUAGE plpgsql;
