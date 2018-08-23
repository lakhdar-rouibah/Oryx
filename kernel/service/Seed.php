<?php
// name of project test.
// Author :  lakhdar.
// Create in  2018-08-21 at 16:11:34.
// Contact : lakhdar-rouibah@live.fr.
// Web : rouibah.fr

// 

namespace app\kernel\service;
use app\kernel\db as db ;

class Seed {

    private $_table;

    /**
     * function to recovred name of table
     *
     * @param [string] $table
     */
    public function __construct ($table) {

        $this->_table = $table;

    }

    /**
     * migrate function to create table 
     * to use:
     * we called it with instance object seed
     * and called method migrate exp:
     * $table = new service\Seed("name_of_table_to_create");
     * to add constraint use ["cons", "and all constraint with ',' between" ]
     * $table->migrate (["id","INT (9) NOT NULL AUTO_INCREMENT"], ["timestamp","DATETIME NOT NULL CURRENT_TIMESTAMP"], ["name","VARCHAR (50) NOT NULL"], ...);
     *
     * @return void
     */
    public function migrate () {

        $table = new db\Migrate ($this->_table);
        $numargs = func_num_args();
        $x;
        if ($numargs >= 2) {

            for ($x = 0; $x < $numargs; $x++){
                $val = trim((string)func_get_arg($x)[0]);
                $table->$val = trim(func_get_arg($x)[1]);
            }

            $table->save($table);
        }

    }
    
    /**
     * save_in_table is function to save information in table
     * to use:
     * we called it with instance object seed
     * and called method migrate exp:
     * $table = new service\Seed("name_of_table");
     * if the name of keys of table have the same name of inputs
     * we use like this 
     * $table->save_in_table ("key1", "key2", ...);
     * else if th names  of keys of table are diffirent than the inputs 
     * we use like this 
     * $table->save_in_table (["id","DEFAULT"], ["timestamp","NOW()"], "key1", "key2", ...);
     *
     * @return void
     */
    public function save_in_table () {

        $table = new db\Seeder ($this->_table);
        $numargs = func_num_args();
        $x;
        if ($numargs >= 2) {
            
                for ($x = 0; $x < $numargs; $x++){

                    $tab = func_get_arg($x);

                    if (is_array($tab)){

                        if(isset( $_POST[  func_get_arg($x)[1]  ] )){

                            $val = trim((string)func_get_arg($x)[0]);
                            $table->$val = trim($_POST[  func_get_arg($x)[1]  ]);
                        }
                    }else {

                        if(isset( $_POST[  func_get_arg($x)  ] )){

                            $val = trim((string)func_get_arg($x));
                            $table->$val = trim($_POST[  func_get_arg($x)  ]);
                        }
                    }

                }

                $table->save($table);
        }

    }    

    /**
     * update_table is function to update information in table
     * to use:
     * we called it with instance object seed
     * and called method migrate exp:
     * $table = new service\Seed("name_of_table");
     * $table->update_table(["name_of_key1","value"],["name_of_key2","value"],  ...);
     *
     * @return void
     */
    public function update_table () {

        $table = new db\Seeder ($this->_table);
        $numargs = func_num_args();
        $x;
        if ($numargs >= 2) {

            for ($x = 1; $x < $numargs; $x++){
                $val = trim((string)func_get_arg($x)[0]);
                $table->$val = trim(func_get_arg($x)[1]);
            }

            $table->update($table, trim((string)func_get_arg(0)[0]), trim((string)func_get_arg(0)[1]));
        }

    }

    /**
     * search_table is function to recovred information into table
     * to use :
     * we called it with instance object seed
     * and called method migrate exp:
     * $table = new service\Seed("name_of_table");
     * in this exp search where 'name_of_key' = 'value'
     * $table->search_table(["name_of_key1","value"],["name_of_key2","value"],  ...);
     * else if we need to recovred all
     * we use 
     * $table->search_table();
     *
     * @return array
     */
    public function search_in_table () {

        $table = new db\Seeder ($this->_table);
        $numargs = func_num_args();
        $x;
        
        if ($numargs){
            for ($x = 0; $x < $numargs; $x++){
                $val = trim((string)func_get_arg($x)[0]);
                $table->$val = trim(func_get_arg($x)[1]);
            }

            $res = $table->find($table, '*');
        }else {

            $res = $table->find($table, '*');
        }

            return $res;

    }
}

