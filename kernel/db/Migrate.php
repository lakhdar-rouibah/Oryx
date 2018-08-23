<?php

namespace app\kernel\db;
use app\kernel\db as db;
class Migrate {
    
    private $properties;
    public $_table;
    private $_values;
    private $_pdo;

    /**
     * __construct function to recovred PDO
     * and initilised it
     *
     * @param [String] $table
     */
    public function __construct ($table) {
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
     * save function to create table if not exists
     *
     * @param [Array] $elem
     * @return void
     */
    public function save($elem){

        $array = get_object_vars($elem);
        $elem_table =$array['properties'];

        foreach($elem_table as $k=> $v){

            

            if($k == 'cons'){

                $cons .= $v;
            }else {

                $element_table .= $k."  ".$v." ,";
            }
        }

        $element_table = substr($element_table, 0, -1);
        $sql = "CREATE TABLE IF NOT EXISTS ".$this->_table ." (".$element_table.", ".$cons.")ENGINE=InnoDB DEFAULT CHARSET=utf8;";

        echo $sql;

        $req = $this->_pdo->exec($sql)or print_r($this->_pdo->errorInfo());

    }

}