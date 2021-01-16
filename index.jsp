<!DOCTYPE html>
<html lang="en">
<head>
<title>Medical EMR</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {
  box-sizing: border-box;
}

body {
    font-family: "Roboto","Helvetica Neue",Helvetica,Arial,sans-serif;
    font-size: 16px;
    font-weight: 400;
    letter-spacing: 0;
    line-height: 1.6;
    color: #666;
    background-color: #fff;
}

/* Style the header */
header {
 /* background-color: #666;
  padding: 30px;
  text-align: center;
  font-size: 35px;
  color: white;*/
  box-sizing : border-box;
color :rgb(102, 102, 102);
display : block;
font-family :Roboto, "Helvetica Neue", Helvetica, Arial, sans-serif;
font-size :16px;
font-weight :400;
height :145px;
letter-spacing :normal;
line-height :25.6px;
text-rendering: optimizelegibility;
text-size-adjust :100%;
width: 417.333px;
-webkit-font-smoothing: antialiased;
-webkit-tap-highlight-color :rgba(0, 0, 0, 0);
}

/* Create two columns/boxes that floats next to each other */
nav {
  float: left;
  width: 30%;
  height: 300px; /* only for demonstration, should be removed */
  background: #ccc;
  padding: 20px;
}

/* Style the list inside the menu */
nav ul {
  list-style-type: none;
  padding: 0;
}

article {
  float: left;
  padding: 20px;
  width: 70%;
  background-color: #f1f1f1;
  height: 300px; /* only for demonstration, should be removed */
}

/* Clear floats after the columns */
section::after {
  content: "";
  display: table;
  clear: both;
}

/* Style the footer */
footer {
  background-color: #777;
  padding: 10px;
  text-align: center;
  color: white;
}

/* Responsive layout - makes the two columns/boxes stack on top of each other instead of next to each other, on small screens */
@media (max-width: 600px) {
  nav, article {
    width: 100%;
    height: auto;
  }
}
</style>
</head>
<body>

<header>
  <h2>Medical EMR</h2>
</header>

<section>
  <nav>
    <ul>
     <li><a href="patient/all_patients.jsp">Patients</a></li>
      <li><a href="ProcedureServlet?action=LIST">Procedures</a></li>
   	<li><a href="patient/">Patient Visit</a></li>
    </ul>
  </nav>
  
  <article>
    <h1>London</h1>
    <p>London is the capital city of England. It is the most populous city in the  United Kingdom, with a metropolitan area of over 13 million inhabitants.</p>
    <p>Standing on the River Thames, London has been a major settlement for two millennia, its history going back to its founding by the Romans, who named it Londinium.</p>
  </article>
</section>

<footer>
  <p>Footer</p>
</footer>

</body>
</html>
