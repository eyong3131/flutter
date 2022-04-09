const express = require('express')
const app = express()
const bodyParser = require("body-parser");
const mysql = require('mysql');
const pool  = mysql.createPool({
  connectionLimit : 10,
  host            : '66.94.102.243',
  user            : 'root',
  password        : 'P@ssw0rd',
  database        : 'dtr'
});

app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json()) 

app.get('/', function (req, res) {
    res.send('Hello World')
})

app.get('/', function (req, res) {
    console.log(req.body)
    res.send('Hello World from POST')
})

app.post('/api/employee', function (req, res) {
    pool.query('SELECT * from employee', function (error, results, fields) {
        if (error) {
            console.log(results);
            res.status(500).json({error: error});
        } else {

            for (let index = 0; index < results.length; index++) {
                const element = results[index];
                console.log(element);  
            }

            
            res.status(200).json(results);
        };
        
      });

    
})

app.post('/api/employee/add', function (req, res) {
   
    var payload = req.body;
    console.log(payload);
    //res.status(200).json({});

    var sql = "insert into employee(id, lastname, firstname, middlename) values(?, ?, ?, ?)"
    pool.query(sql, [req.body.id, req.body.lastname, req.body.firstname, req.body.middlename], function (error, results, fields) {
        if (error) {
            console.log(results);
            res.status(500).json({error: error});
        } else {
            console.log(results);
            res.status(200).json(results);
        };
        
      });

    
})

const server = app.listen(3000, () => {
    console.log('server started')
});