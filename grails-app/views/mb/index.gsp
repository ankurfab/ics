<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>ICS : Marriage Board</title>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'icsmb.ico')}" type="image/x-icon">
    <r:require module="mbHome"/>
    <r:layoutResources />
    <link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
</head>

<body>

    <!-- Navigation -->
    <a id="menu-toggle" href="#" class="btn btn-dark btn-lg toggle"><i class="fa fa-bars"></i></a>
    <a id="navbrand" href="#" class="pull-left"><r:img dir="images" file="mb_logo1.png"/></a>
    <nav id="sidebar-wrapper">
        <ul class="sidebar-nav">
            <a id="menu-close" href="#" class="btn btn-light btn-lg pull-right toggle"><i class="fa fa-times"></i></a>
            <li class="sidebar-brand">
                <a href="#top"  onclick = $("#menu-close").click(); >ICS MB</a>
            </li>
            <li>
                <a href="#top" onclick = $("#menu-close").click(); >Home</a>
            </li>
            <li>
                <a href="#about" onclick = $("#menu-close").click(); >About</a>
            </li>
            <li>
                <a href="#services" onclick = $("#menu-close").click(); >Services</a>
            </li>
            <li>
                <a href="#howto" onclick = $("#menu-close").click(); >How Tos</a>
            </li>
            <li>
                <a href="#faq" onclick = $("#menu-close").click(); >FAQs</a>
            </li>
        </ul>
    </nav>

    <!-- Header -->
    <header id="top" class="header">
        <div class="text-vertical-center" style="color: #E0FF84;">
            <h2>ISKCON Community Services</h2>
            <h1>Marriage Board</h1>
            <br>
            <a href="/ics/mb/mbLogin" class="btn btn-dark btn-lg">Proceed</a>
        </div>
    </header>

    <!-- About -->
    <section id="about" class="about">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2>We at Marriage Board are Committed to Finding you the suitable Krishna Counscious Life partner to assist you in your Service to Their Lordships..</h2>
                    <p class="lead">Register for the Marriage Board by <a target="_blank" href="http://join.deathtothestockphoto.com/">Clicking here.</a>.</p>
                </div>
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>

    <!-- Services -->
    <!-- The circle icons use Font Awesome's stacked icon classes. For more information, visit http://fontawesome.io/examples/ -->
    <section id="services" class="services bg-primary">
        <div class="container">
            <div class="row text-center">
                <div class="col-lg-10 col-lg-offset-1">
                    <h2>MB Services</h2>
                    <hr class="small">
                    <div class="row">
                        <div class="col-md-4 col-sm-6">
                            <div class="service-item">
                                <span class="fa-stack fa-4x">
                                <i class="fa fa-circle fa-stack-2x"></i>
                                <i class="fa fa-magic fa-stack-1x text-primary"></i>
                            </span>
                                <h4>
                                    <strong>Devotee Match Making</strong>
                                </h4>
                                <p>Find the right candidate to your expectations</p>
                                <a href="#" class="btn btn-light">Learn More</a>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <div class="service-item">
                                <span class="fa-stack fa-4x">
                                <i class="fa fa-circle fa-stack-2x"></i>
                                <i class="fa fa-compass fa-stack-1x text-primary"></i>
                            </span>
                                <h4>
                                    <strong>Marriage Counselling</strong>
                                </h4>
                                <p>Guidance in terms of going through the process of marriage.</p>
                                <a href="#" class="btn btn-light">Learn More</a>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <div class="service-item">
                                <span class="fa-stack fa-4x">
                                <i class="fa fa-circle fa-stack-2x"></i>
                                <i class="fa fa-flask fa-stack-1x text-primary"></i>
                            </span>
                                <h4>
                                    <strong>Photo Gallery</strong>
                                </h4>
                                <p>Checkout some of the memories created part of our activities</p>
                                <a href="#" class="btn btn-light">Learn More</a>
                            </div>
                        </div>
                    </div>
                    <!-- /.row (nested) -->
                </div>
                <!-- /.col-lg-10 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>
    <!-- Portfolio -->
    <section id="howto" class="portfolio">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 col-lg-offset-1 text-center">
                    <h2>How Tos</h2>
                    <hr class="small">
                    <div class="row text-left">
                        <div class="col-xs-12">
                            ${ics.Content.findWhere(name:'hotos',language:'ENGLISH',category:'MB')?.htmlContent}
                        </div>
                    </div>
                </div>
                <!-- /.col-lg-10 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>

    <section id="faq" class="portfolio">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 col-lg-offset-1 text-center">
                    <h2>Frequently Asked Questions</h2>
                    <hr class="small">
                    <div class="row text-left">
                        <div class="col-xs-12">
                            ${ics.Content.findWhere(name:'faqs',language:'ENGLISH',category:'MB')?.htmlContent}
                        </div>
                    </div>
                </div>
                <!-- /.col-lg-10 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>
<hr>
<footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-10 col-lg-offset-1 text-center">
                    <h4><strong>ISKCON Community Services : Marriage Board</strong>
                    </h4>
                    <p>ISKCON Chowpatty, 7 K.M.Munshi Road, Girgaon Chowpatty, Mumbai<br>ISKCON NVCC, Katraj Kondhwa Road Pune</p>
                    <ul class="list-unstyled">
                        <li><i class="fa fa-envelope-o fa-fw"></i>  <a href="spd@gmail.com">rk.mb.system@gmail.com</a>
                        </li>
                    </ul>
                    %{--<ul class="list-inline">
                        <li>
                            <a href="#"><i class="fa fa-facebook fa-fw fa-3x"></i></a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-twitter fa-fw fa-3x"></i></a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-dribbble fa-fw fa-3x"></i></a>
                        </li>
                    </ul>--}%
                    <hr class="small">
                    <p class="text-muted">Served by <a href="http://konsoftech.in">Konsoftech</a></p>
                </div>
            </div>
        </div>
    </footer>
<r:layoutResources />
    <script>
    // Closes the sidebar menu
    $("#menu-close").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });

    // Opens the sidebar menu
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });

    // Scrolls to the selected menu item on the page
    $(function() {
        $('a[href*=#]:not([href=#])').click(function() {
            if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') || location.hostname == this.hostname) {

                var target = $(this.hash);
                target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                if (target.length) {
                    $('html,body').animate({
                        scrollTop: target.offset().top
                    }, 1000);
                    return false;
                }
            }
        });
    });
    </script>

</body>

</html>
