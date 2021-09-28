<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>MyTickets | Account</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/1a63ab4674.js" crossorigin="anonymous"></script>
    <link href='https://fonts.googleapis.com/css?family=Aldrich' rel='stylesheet'>
          <link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet">
              <script
      src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.js"
      defer
    ></script>
    <style>
    ::-webkit-scrollbar {
      width: 10px;
    }
    ::-webkit-scrollbar-track {
      box-shadow: inset 0 0 5px white;
    }
    ::-webkit-scrollbar-thumb {
      background-color:white;
    }
    ::-webkit-scrollbar-thumb:hover {
        background-color:slateblue;
    }
    .header{
      width:100%;
      position: fixed;
      z-index:1;
      float:left;
      top:0;
      left:0;
      background-color: white;
    }
    .header th,tr{
        padding:0px;
    }
    .icon{
      font-size:35px;
    }
    .nav-btn{
      border-radius: 0px;
      border: none;
      margin:0px;
      width:100%;
      padding: 10px;
      color:slateblue;
      background-color: white;
    }
    .nav-btn:hover,.nav-btn:focus,.nav-btn:active{
      background-color:#6366F1;
      outline: 1px #6366F1;
      color:white;
    }
label{
  margin-left:10px;
  color:#6366F1;
}
    .user-info{
      margin-left: auto;
      margin-right: auto;
      margin-top:15vh;
      width:50%;
      background-color: white;
    }
    .form-control{
      margin:7px;
      height:50px;
      padding-left: 10px;
    }
    option{
      font-size: 20px;
    }
    .ticks{
      margin-top: 10vh;
    }
    .ticket{
    background-color:white;
    box-shadow:0px 3px 6px rgba(0,0,0,0.4);
    border-radius:8px;
    margin:12px;
    }
    @media (max-width:762px) {
      .user-info{
        width:80%;
      }
    }
    .table th{
    color:slateblue;
    }
      </style>

</head>
<body class="bg-gray-100">

    <div id="bookings"></div>
    <div id="account"></div>
    <script>


        var xhttp = new XMLHttpRequest();
		 
	    xhttp.onreadystatechange = function() {
	    	
	      if (this.readyState == 4 && this.status == 200) {
	    	  document.getElementById('account').innerHTML=this.responseText;
	      }
	    };
	    xhttp.open("GET", "updateprofile",true);
	    xhttp.send();
         xhttp = new XMLHttpRequest();
		 
	    xhttp.onreadystatechange = function() {
	    	
	      if (this.readyState == 4 && this.status == 200) {
	    	  document.getElementById('bookings').innerHTML=this.responseText;
	      }
	    };
	    xhttp.open("GET", "trans",true);
	    xhttp.send();
    
    </script>

</body>
</html>