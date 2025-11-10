DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'habit_user') THEN
        CREATE ROLE habit_user LOGIN;
    END IF;
END$$;
