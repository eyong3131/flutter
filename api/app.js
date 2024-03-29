// express and cors enable remote database access
const express = require('express');
const cors = require('cors');
const app = express();
//body parser is where we used to pass data from flutter to node so we can either add or delete to database
const bodyParser = require("body-parser");
// this is needed if our database is mysql
const mysql = require('mysql');
// setting up connection to remote or localhost database
const pool = mysql.createPool({
    connectionLimit: 10,
    host: '162.241.216.80',
    user: 'jpdzalmy_eyong',
    password: 'b7hAgm_]M?74',
    database: 'jpdzalmy_rebago_db'
});

const server = app.listen(3306, () => {
    console.log('server started')
});
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());


// Transaction Program list
app.post('/api/qwing/transactionProgList', function (req, res) {
    pool.query('SELECT  TBL_PROGRAM.PROGRAM_ACRONYM FROM `TBL_PROGRAM`  LIMIT 100', function (error, results, fields) {
        if (error) {
            //console.log(results);
            res.status(500).json({ error: error });
        } else {
            for (let index = 0; index < results.length; index++) {
                const element = results[index];
                console.log(element);
            }
            res.status(200).json(results);
        };
    });
})

/*
SELECT TRANSACTION_ID FROM TBL_TRANSACTIONS WHERETRANSACTION_NAME = ? AND TRANSACTION_MIDDLENAME = ? AND TRANSACTION_LASTNAME = ? AND TRANSACTION_TIMESTAMP <= CURRENT_TIMESTAMPORDER BY TRANSACTION_TIMESTAMP DESC
*/
// Transaction push
app.post('/api/qwing/transactionId', function (req, res) {
    var fname = req.body.firstname;
    var mname = req.body.middlename;
    var lname = req.body.lastname;
    var program = req.body.program;
    var purpose = req.body.purpose;
    var sql = "SELECT TRANSACTION_ID FROM TBL_TRANSACTIONS WHERETRANSACTION_NAME = ? AND TRANSACTION_MIDDLENAME = ? AND TRANSACTION_LASTNAME = ? AND TRANSACTION_TIMESTAMP <= CURRENT_TIMESTAMPORDER BY TRANSACTION_TIMESTAMP DESC";
    pool.query(sql, [fname,mname,lname,program,purpose], function (error, results, fields) {
        if (error) {
            //req.body.program;
            console.log(error);
            res.status(500).json({ error: error });
        } else {
            /*
            for (let index = 0; index < results.length; index++) {
                const element = results[index];
                console.log(element);
            }
            */
            req.body.program;
        };
    });
})

// transaction pull data
app.post('/api/qwing/transactionPull', function (req, res) {
    pool.query('SELECT * FROM `TBL_TRANSACTIONS`', function (error, results, fields) {
        if (error) {
            //console.log(results);
            res.status(500).json({ error: error });
        } else {
            for (let index = 0; index < results.length; index++) {
                const element = results[index];
                console.log(element);
            }
            res.status(200).json(results);
        };
    });
})
// Transaction push
app.post('/api/qwing/transactionPush', function (req, res) {
    var fname = req.body.firstname;
    var mname = req.body.middlename;
    var lname = req.body.lastname;
    var program = req.body.program;
    var purpose = req.body.purpose;
    var sql = "INSERT INTO `TBL_TRANSACTIONS` (`TRANSACTION_ID`, `TRANSACTION_NAME`,`TRANSACTION_MIDDLENAME`,`TRANSACTION_LASTNAME`, `TRANSACTION_PROGRAM` ,`TRANSACTION_PURPOSE`) VALUES (NULL, ?, ?,?,?,?) ";
    pool.query(sql, [fname,mname,lname,program,purpose], function (error, results, fields) {
        if (error) {
            //req.body.program;
            console.log(error);
            res.status(500).json({ error: error });
        } else {
            /*
            for (let index = 0; index < results.length; index++) {
                const element = results[index];
                console.log(element);
            }
            */
            req.body.program;
        };
    });
})



// Login Form hash Test
app.post('/api/hash_test', function (req, res) {
    pool.query('SELECT * FROM jpdzalmy_rebago_db.hash_test', function (error, results, fields) {
        if (error) {
            //console.log(results);
            res.status(500).json({ error: error });
        } else {
            for (let index = 0; index < results.length; index++) {
                const element = results[index];
                console.log(element);
            }
            res.status(200).json(results);
        };
    });
})
