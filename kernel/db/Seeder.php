<?php

namespace app\kernel\db;
use app\kernel\db;
class Seeder {
    
    private $properties;
    private $_valeurs;
    private $_clefs;
    private $_table;
    private $_pdo;

    /**
     * construct function to recovred the PDO
     * and initialise it
     *
     * @param [string] $table
     */
    public function __construct($table) {

        $dsn = new db\Database();
        $this->_pdo = $dsn->dbn();
        $this->_table = $table;

    }
    
    /**
     * __get magic function
     *
     * @param [String] $propertyName
     * @return array
     */
    public function __get($propertyName){
        if(array_key_exists($propertyName, $properties)){
            return $this->properties[$propertyName];
        }
    
    } 

    /**
     * __set magic  function
     *
     * @param [String] $propertyNane
     * @param [String] $propertyValue
     */
    public function __set($propertyNane, $propertyValue){
        $this->properties[$propertyNane] = $propertyValue;
    } 

    /**
     * save function to save information in the tbale of bdd
     * it recovred the values of the array and set it in the table
     * @param [array] $elem
     * @return void
     */
    public function save($elem){

        $array = get_object_vars($elem);
        $update =$array['properties'];

        foreach($update as $k=> $v){

            $up .= $k.' = '."'".$v."' ,";

            $this->_clefs .= $k.',';

            if($this->check_sql_function ($v) == true){

                $this->_valeurs .= $v." ,";
            }else {

                $this->_valeurs .= "'".$v."' ,";
            }
        }

        $this->_clefs = substr($this->_clefs, 0, -1);
        $this->_valeurs = substr($this->_valeurs, 0, -1);

        $sql =  "INSERT INTO ".$this->_table." (".$this->_clefs.")  VALUES ( ".$this->_valeurs." )";
        $req = $this->_pdo->exec($sql) or print_r($this->_pdo->errorInfo());

    }

    /**
     * update function to update information in the table
     * ii recovred 
     * the values of the array 
     * the keys and vlues of keys
     * and set it in the table where the key equale the value
     * @param [array] $elem
     * @param [String] $key
     * @param [String] $val
     * @return void
     */
    public function update($elem, $key, $val){

        $array = get_object_vars($elem);
        $update =$array['properties'];

        foreach($update as $k=> $v){

            $up .= $k.' = '."'".$v."' ,";

        }

        $up = substr($up, 0, -1);

        $sql = "UPDATE ".$this->_table." SET ".$up." WHERE ".$key." = '".$val."'";
        $req = $this->_pdo->exec($sql) or print_r($this->_pdo->errorInfo());

    }

    /**
     * find function to search information in table
     * find in table where prperties of Array
     * @param [Array] $elem
     * @param [string] $search
     * @return void
     */
    public function find($elem, $search){

        $x = 0;

        
        $array = get_object_vars($elem);
        $update =$array['properties'];
        
        if ($update != null){
            foreach($update as $k=> $v){

                

                if ($x > 0){

                    $up .= "AND ".$k.' = '."'".$v."' ";
                }else {

                    $up .= $k.' = '."'".$v."' ";
                }

                $x++;
            }

            $sql = "SELECT ".$search." FROM ".$this->_table." WHERE ".$up;
            $sth = $this->_pdo->query($sql) or print_r($this->_pdo->errorInfo());
            $result = $sth->fetchAll();

            return $result;
        }else {

                $sql = "SELECT ".$search." FROM ".$this->_table;
                $sth = $this->_pdo->query($sql) or print_r($this->_pdo->errorInfo());
                $result = $sth->fetchAll();

                return $result;

        }


    }

    /**
     * check_sql_function function to check
     * if key existe in syntax of sql
     *
     * @param [type] $value
     * @return true or false
     */
    private function check_sql_function ($value){

        $lines = file('./file_sql.sq');
        foreach($lines as $line){

            $line = substr($line, 0, -1);

            if($line == $value){

                return true;
            }
        }
    }
}