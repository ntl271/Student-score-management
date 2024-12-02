<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
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
            <div class="col-sm-6 d-none d-sm-block">
                <img src="https://img.pikbest.com/png-images/20210912/back-to-school-teacher-student-cheerful-cute-cartoon-classroom-png%E2%80%8B-and%E2%80%8B-psd%E2%80%8B-%E2%80%8Bfile_6118428.png!w700wp"
                     alt="Register image" class="w-100 vh-100" style="object-fit: cover; object-position: right;">
            </div>
            <div class="col-sm-6 px-0 text-black">

                <div class="d-flex align-items-center h-custom-2 px-5 ms-xl-4 mt-5 pt-5 pt-xl-0 mt-xl-n5">

                    <form action="${pageContext.request.contextPath}/Register" method="post" style="width: 23rem;">
                        <h3 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Register</h3>

                        <div data-mdb-input-init class="form-outline mb-4">
                            <label class="form-label" for="form3Example1">Full Name</label>
                            <input type="text" id="form3Example1" name="name" class="form-control form-control-lg" required />
                        </div>

                        <div data-mdb-input-init class="form-outline mb-4">
                            <label class="form-label" for="form3Example2">Email address</label>
                            <input type="email" id="form3Example2" name="email" class="form-control form-control-lg" required />
                        </div>

                        <div data-mdb-input-init class="form-outline mb-4">
                            <label class="form-label" for="form3Example3">Phone</label>
                            <input type="phone" id="form3Example3" name="phone" class="form-control form-control-lg" required />
                        </div>

                        <div data-mdb-input-init class="form-outline mb-4">
                            <label class="form-label" for="form3Example4">Password</label>
                            <input type="password" id="form3Example4" name="password" class="form-control form-control-lg" required />
                        </div>

                        <div data-mdb-input-init class="form-outline mb-4">
                            <label class="form-label" for="form3Example5">Confirm Password</label>
                            <input type="password" id="form3Example5" name="confirmPassword" class="form-control form-control-lg" required />
                        </div>

                        <div class="pt-1 mb-4">
                            <button data-mdb-button-init data-mdb-ripple-init class="btn btn-info btn-lg btn-block" type="submit">Register</button>
                        </div>

                        <p>Already have an account? <a href="${pageContext.request.contextPath}/views/login.jsp" class="link-info">Log in here</a></p>
                    </form>

                </div>

            </div>

        </div>
    </div>
</section>
</body>
</html>
