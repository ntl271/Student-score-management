<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>

    <style>
        .bg-image-vertical {
            position: relative;
            overflow: hidden;
            background-repeat: no-repeat;
            background-position: right center;
            background-size: auto 100%;
        }

        @media (min-width: 1025px) {
            .h-custom-2 {
                height: 100%;
            }
        }
    </style>
</head>
<body>
<section class="vh-100">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-6  d-none d-sm-block">
                <img src="https://img.pikbest.com/png-images/20210912/back-to-school-teacher-student-cheerful-cute-cartoon-classroom-png%E2%80%8B-and%E2%80%8B-psd%E2%80%8B-%E2%80%8Bfile_6118428.png!w700wp"
                     alt="Login image" class="w-100 vh-100" style="object-fit: cover; object-position: right;">
            </div>
            <div class="col-sm-6 px-0 text-black">
<%--                <div class="px-5 ms-xl-4">--%>
<%--                    <img width="200" height="200" style="margin: 0 50px" src="https://img.icons8.com/glyph-neue/64/school.png" alt="school"/>--%>
<%--                </div>--%>

                <div class="d-flex align-items-center h-custom-2 px-5 ms-xl-4 mt-5 pt-5 pt-xl-0 mt-xl-n5">

                    <form action="${pageContext.request.contextPath}/Login" method="post" style="width: 23rem;">
                    <h3 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Log in</h3>

                        <div class="form-outline mb-4">
                            <label class="form-label" for="form2Example18">Email address</label>
                            <input type="email" id="form2Example18" name="email" class="form-control form-control-lg" required />
                        </div>

                        <div class="form-outline mb-4">
                            <label class="form-label" for="form2Example28">Password</label>
                            <input type="password" id="form2Example28" name="password" class="form-control form-control-lg" required />
                        </div>

                        <div class="pt-1 mb-4">
                            <button class="btn btn-info btn-lg btn-block" type="submit">Login</button>
                        </div>

                        <% if (request.getParameter("error") != null) { %>
                        <div class="alert alert-danger" role="alert">
                            Invalid email or password. Please try again.
                        </div>
                        <% } %>
                        <p>Don't have an account? <a href="/views/register.jsp" class="link-info">Register here</a></p>

                    </form>

                </div>

            </div>

        </div>
    </div>
</section>
</body>
</html>
