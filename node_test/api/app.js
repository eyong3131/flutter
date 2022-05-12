const express = require('express');
const app = express();
const bodyParser = require("body-parser");
const mysql = require('mysql');
const pool = mysql.createPool({
    connectionLimit: 10,
    host: 'localhost',
    user: 'root',
    password: '0505',
    database: 'viral.com'
});
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())

app.post('/api/patient', function (req, res) {
    pool.query('SELECT * from patient_details', function (error, results, fields) {
        if (error) {
            //console.log(results);
            res.status(500).json({ error: error });
        } else {
            /*
            for (let index = 0; index < results.length; index++) {
                const element = results[index];
                console.log(element);
            }
            */
            res.status(200).json(results);
        };
    });
})
app.post('/api/patient/payload', function (req, res) {
    //var payload = req.body;
/*
console.log("_________________________");
console.log(typeof (req.body));
console.log("_________________________");
console.log(req.body);
var payload = req.body;
console.log(payload);
*/
//var sql = "insert into employee(id, lastname, firstname, middlename) values(?, ?, ?, ?)"
var sql = "INSERT INTO `itexmo`(`code`, `password`) VALUES (?, ?)"
pool.query(sql, [req.body.name, req.body.lname], function (error, results, fields) {
    if (error) {
        //console.log(results);
        res.status(500).json({ error: error });
    } else {
        //console.log(results);
        res.status(200).json(results);
    };

});
})

const server = app.listen(3000, () => {
console.log('server started')
});