use TransComp


CREATE LOGIN user_login WITH PASSWORD = 'password';
CREATE LOGIN driver_login WITH PASSWORD = 'password';
CREATE LOGIN admin_login WITH PASSWORD = 'password';



USE TransComp;

CREATE USER user_name FOR LOGIN user_login;
CREATE USER driver_name FOR LOGIN driver_login;
CREATE USER admin_name FOR LOGIN admin_login;