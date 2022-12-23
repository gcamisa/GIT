begin
    for x in (
            select Sid, Serial#, machine, program
            from v$session
            where
                machine like 'asprodises%'
        ) loop
        execute immediate 'Alter System Kill Session '''|| x.Sid
                     || ',' || x.Serial# || ''' IMMEDIATE';
    end loop;
end;
