#!/bin/sh
#_________________________ Include ______________________________
date=$(date '+%Y-%m-%d')
hour=$(date +"%T")
#________________________________________ Menu ___________________________
menu () {
    # start script
    echo  'app is ready what do you want to do? ->

            \033[36m 1. Create a new project\033[0m
            \033[36m 2. Open a project\033[0m'

    echo "Enter option (exp '1' for Create a new project) ->"; 
    read request
    return $request
}

choiceProject () {
    
    case $1 in
        1) createClass $2;;
        2) loadPackage $2;;
        3) loadModul $2;; #________________________________________________________
        4) createModul $2 ;;
        *) echo  "\033[31mInvalid option ! ->\033[0m" ;
    esac
}

menuProject () {
    # start script
    echo  $1" is ready what do you want to do? ->
    
            \033[36m 1. Create a new class\033[0m
            \033[36m 2. load a new package\033[0m
            \033[36m 3. load a new modul html\033[0m
            \033[36m 4. create a new modul html\033[0m"

    echo "

Enter option (exp '1' for Create a new class) ->"; 
    read request
    choiceProject $request $1
}

# help () {


# }

# #________________________________________ Check ___________________________

# function for gitignor
gitIgnore () {
projectName=$1
echo '/.vscode
/Core/app/kernel/db/Database.php
/scss
/'$projectName' .code-workspace
*.DS_Store
.gitignore
'>> ./$projectName/.gitignore
}

# function to push to gitHub
gitPush() {

    git remote set-url origin https://uwindaji:enauoram29*@github.com/uwindaji/oryx.git
    git rm --cached -f *.DS_Store
    git init
    git add .

    echo "add your commit"
    read commit
    git commit -m "'$commit'"

    git remote add origin https://uwindaji:enauoram29*@github.com/uwindaji/oryx.git
    git push -u origin master
}

# check folder {param String}
checkFolder () {

    if [ -d $1 ];
    then
        return 0
    else
        return 1
    fi
}

# check file {param String}
checkFile () {

    if [ -f $1 ];
    then
        return 0
    else
        return 1
    fi
}

#________________________________________ project ___________________________
# script for a new project
# function to create a new project
generateProject () {
    #create folders
    mkdir ./$projectName
    mkdir ./$projectName/css
    mkdir ./$projectName/scss
    mkdir ./$projectName/.vscode
    mkdir ./$projectName/img
    mkdir ./$projectName/js
    mkdir ./$projectName/Core
    mkdir ./$projectName/Core/app/
    mkdir ./$projectName/Core/app/kernel
    mkdir ./$projectName/Core/app/kernel/service
    mkdir ./$projectName/Core/app/kernel/db
    mkdir ./$projectName/Core/console
    mkdir ./$projectName/Core/controlers
    mkdir ./$projectName/Core/models
    mkdir ./$projectName/Core/views


    #create files in folders
    touch ./$projectName/scss/_var.scss
    touch ./$projectName/scss/styles.scss
    touch ./$projectName/scss/resp.scss
    touch ./$projectName/js/app.js
    touch ./$projectName/Core/Autoload.php
    touch ./$projectName/Core/app/kernel/db/Database.php
    touch ./$projectName/Core/controlers/Rooter.php
    touch ./$projectName/Core/views/Head.php
    touch ./$projectName/Core/views/Footer.php
    touch ./$projectName/index.php

#insert code in Database.php Database
echo '<?php
// name of project '$projectName'.
// Author :  lakhdar.
// Create in  '$date' at '$hour'.
// Contact : lakhdar-rouibah@live.fr.
// Web : rouibah.fr
namespace app\kernel\db;
use PDO;


class Database {

private $_host = "'$hostname'";
private $_user = "'$username'";
private $_password = "'$password'";
private $_bdd = "'$db_name'";
public $_pdo;

    public function __construct (){

            try {
                    $dsn = new \\PDO("mysql:host=".$this->_host, $this->_user, $this->_password);
                    $sql = "CREATE DATABASE IF NOT EXISTS `$this->_bdd` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci";
                    $dsn->query($sql);

                } catch (PDOException $e) {
                    die("DB ERROR: ". $e->getMessage());
                }


    }


    public function dbn() {
        try { 

            $this->_pdo = new \\PDO("mysql:dbname=".$this->_bdd.";host=".$this->_host, $this->_user, $this->_password, array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"));
            return $this->_pdo;
        }
        catch (Exception $e) {die("impossible de se connecter a la base de données ");
        
        }
    }
}
'>> ./$projectName/Core/app/kernel/db/Database.php

#insert code in Autoload.php 
echo '<?php
// name of project '$projectName'.
// Author :  lakhdar.
// Create in  '$date' at '$hour'.
// Contact : lakhdar-rouibah@live.fr.
// Web : rouibah.fr

class Autoload {

    public function __construct() {
        
        $this->loader();
    } 

    public function loader() {
        spl_autoload_register(function ($class) {
            $class= str_replace("\\\", "/" , $class);
            $filename = "./Core/".$class.".php";
            require_once ($filename);
        });

    }
}

$autoload = new Autoload();

'>> ./$projectName/Core/Autoload.php

# create scss file
echo '@import "_var.scss"'>> ./$projectName/scss/styles.scss
echo '@import "_var.scss"'>> ./$projectName/scss/resp.scss

# create Rooter.php
echo '<?php
// name of project '$projectName'.
// Author :  lakhdar.
// Create in  '$date' ******* AT '$hour'.
// Contact : lakhdar-rouibah@live.fr.
// Web : rouibah.fr

class Rooter {
    /**
    * Rooter to recovred view and model
    *
    * @param [String] $req
    */
    public function __construct($req) {
        // recovred the view
        require_once "./Core/models/".$req.".php";
        // recovred the model
        require_once "./Core/views/".$req.".php";
    }
}'>> ./$projectName/Core/controlers/Rooter.php



    if [ $boots = 'y' ]
    then

            
            wget -P ./$projectName/ https://raw.githubusercontent.com/uwindaji/oryx/master/vscode/vs.code-workspace
            mv './'$projectName'/vs.code-workspace'  './'$projectName'/'$projectName'.code-workspace'
            wget -P ./$projectName/.vscode https://raw.githubusercontent.com/uwindaji/oryx/master/vscode/settings.json
            wget -P ./$projectName/css https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css
            wget -P ./$projectName/js https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js

            wget -P ./$projectName/js https://code.jquery.com/jquery-3.3.1.slim.min.js
            wget -P ./$projectName/js https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js

            btcss='./css/bootstrap.min.css'
            btjs='./js/bootstrap.min.js'
            jq='./js/jquery-3.3.1.slim.min.js'
            popper='./js/popper.min.js'

#insert code in Head.php with bootstrap
echo '<!DOCTYPE html>
<html lang="'$language'">
<head>
    <!--
    // name of project '$projectName'.
    //Script create by lakhdar.
    // Date '$date' at '$hour'.
    // Contact: lakhdar-rouibah@live.fr.
    // Web : rouibah.fr
    -->

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>'$title'</title>
    <link rel="stylesheet" href="'$btcss'">
    <link rel="stylesheet" href="./css/styles.min.css">
    <link rel="stylesheet" href="./css/resp.min.css">
</head>
<body>\n
        '>> ./$projectName/Core/views/Head.php

    #insert code in Footer.php with bootstrap
    echo '
<script src="'$jq'"></script>
<script src="'$popper'"></script>
<script src="'$btjs'"></script>
<script src="./js/app.js"></script>
</body>
</html>
'>> ./$projectName/Core/views/Footer.php
            
    else
#insert code in Head.php without bootstrap
echo '<!DOCTYPE html>
<html lang="'$language'">
<head>
    <!--
    // name of project '$projectName'.
    //Script create by lakhdar.
    // Date '$date' at '$hour'.
    // Contact: lakhdar-rouibah@live.fr.
    // Web : rouibah.fr
    -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>'$title'</title>
    <link rel="stylesheet" href="./css/styles.min.css">
    <link rel="stylesheet" href="./css/resp.min.css">
</head>
<body>\n
    '>> ./$projectName/Core/views/Head.php

#insert code in Head.php without bootstrap
echo '
    <script src="./js/app.js"></script>
</body>
</html>
    '>> ./$projectName/Core/views/Footer.php
    fi



#insert code in index.php
echo '<?php
// name of project '$projectName'.
//Script create by Lakhdar.
// Date '$date'  at '$hour'.
// Contact: lakhdar-rouibah@live.fr.
// Web : rouibah.fr

//**addExClass***
require_once "./Core/Autoload.php";
require_once "./Core/controlers/Rooter.php";
require_once "./Core/views/Head.php";

if(isset($_GET["req"])){
    
    $request = $_GET["req"];
    
    switch ($request){
        // @addSwitchCase

        // @addDefaultCase
    }
}
require_once "./Core/views/Footer.php";'>> ./$projectName/index.php
gitIgnore $projectName
echo 'project create with success ->';
open ./$projectName/$projectName.code-workspace
menuProject $projectName
}

# function to config a new project
addProject () {

    checkFolder $projectName
    _check=$?
    if [ $_check -eq 0 ];
    then
        echo  "\033[31mProject name existe choose another name ! ->\033[0m"
        read projectName
        addProject $projectName

    elif [ $_check -eq 1 ];
    then
        #create project
        echo "set your language exp: fr for french or en for english ->"
        read language

        # echo "Enter project name ->"
        # read projectName

        echo "Enter hostname ->"
        read hostname

        echo "Enter username ->"
        read username

        echo "Enter password ->"
        read password

        echo "Enter database name ->"
        read db_name

        echo "set the title of your application ->"
        read title

        echo "do you need bootstrap ? set (y) for yes ->"
        read boots 

        generateProject $projectName
    fi
}

# function to open Project
openProject () {

    echo "Enter the name of project ->"
    read projectName

    checkFolder $projectName
    if [ $? -eq 0 ];
    then 

        menuProject $projectName
    else 
        echo  "\033[31mProject not exist ! ->\033[0m"
        openProject
    fi

}


#______________________________________ Modul ______________________________
# function to create modul
createModul () {
    
    project=$1
    echo 'Enter the name of modul'
    read modulName

    modulName="$(tr '[:lower:]' '[:upper:]' <<< ${modulName:0:1})${modulName:1}"
    
    checkFile ./$project/Core/views/$modulName.php
    modulHtml=$?
    checkFile ./$project/Core/models/$modulName.php
    modulPhp=$?
    if [ $modulHtml -eq 0 -o $modulPhp -eq 0 ];
    then
        echo  "\033[31mModul name existe choose another name ! ->\033[0m"
        createModul $project

    elif [ $modulHtml -eq 1 -a $modulPhp -eq 1 ];
    then

        echo 'Enter the description of modul ->'
        read description
        touch ./$project/Core/models/$modulName.php
        touch ./$project/Core/views/$modulName.php

# create model
#project = $2
echo '<?php
// name of project '$project'.
// Author :  lakhdar.
// Create in  '$date' at '$hour'.
// Contact : lakhdar-rouibah@live.fr.
// Web : rouibah.fr

// '$description'

namespace models ;
use models as models;
use app\kernel\service as service;
use app\kernel\db as db ;

class '$modulName' {
    public function __construct() {
        
    }
}'>> ./$project/Core/models/$modulName.php

# create console
echo '<?php
// name of project '$project'.
// Author :  lakhdar.
// Create in  '$date' at '$hour'.
// Contact : lakhdar-rouibah@live.fr.
// Web : rouibah.fr
use modals as models;
$'$modulName' = new models\'$modulName'();

// your script here


'>> ./$project/Core/console/$modulName.console.php

echo '<!-- here your code HTML -->'>> ./$project/Core/views/$modulName.php

        insertModul $project
    fi
}

# function to insert mudul in index.php
insertModul () {
    project=$1

    file=./$project/'index.php'
    lineCase=$(grep -n "@addSwitchCase" $file | cut -d: -f1)
    ex -sc $(($lineCase+1))'i|
        // case for Login modul
        case "'$modulName'";
            // @beforModul_'$modulName'
            require_once "./Core/console/'$modulName'.console.php";
            // @afterModul_'$modulName'
        break;' -cx $file

    echo 'Create Modul success'
    open $project'.code-workspace'
    menuProject $project
}


#______________________________________ Package ______________________________
# function to load a new package
loadPackage() {

    project=$1
    echo 'Enter the name of package'
    read packageName

    checkFile ./$project/Core/app/kernel/package/$packageName.php
    if [ $? -eq 0 ];
    then
        echo "\033[31mPackage existe choose another package ! ->\033[0m"
        loadPackage $project

    elif [ $? -eq 1 ];
    then
        wget -P ./$project/Core/app/kernel/package/ https://raw.githubusercontent.com/uwindaji/oryx/$packageName/settings.json
        menuProject $project
    fi
}


#________________________ Commande _____________________________
menu
case $? in
	1) 
        echo "Enter project name ->"
        read projectName
        addProject $projectName;;

	2) openProject;;
	*) echo  "\033[31mInvalid option ! ->\033[0m" ;;
esac