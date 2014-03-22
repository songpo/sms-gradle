<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>

    <title>登录</title>
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-2.0.3.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-2.0.3.min.map"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/flat-ui/flatui-checkbox.js"></script>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/flat-ui/flat-ui.css" />

    <script>

        $(document).ready(function(){

            $('#login').click(function(){
                if($('#login-user').val() == '')
                {
                    alert("账号不能为空");
                    return;
                }
                if($('#login-pass').val() == '')
                {
                    alert("密码不能为空");
                    return;
                }

                $.ajax({
                    url:'${pageContext.request.contextPath}/login',
                    type:"POST",
                    data:$('#form').serialize(),
                    success: function(data){
                        if(data.success && data.url)
                        {
                            window.location.href = '${pageContext.request.contextPath}' + data.url;
                        }
                    }
                });
            });
        });

    </script>

</head>
<body>
<div class="container">
    <div class="login" style="width: 940px;margin-left: auto; margin-right: auto;">
        <div class="login-screen">
            <div class="login-icon">
                <img src="${pageContext.request.contextPath}/css/images/login/icon.png" alt="Welcome to Mail App">
                <h4>欢迎登录 <small>控制台</small></h4>
            </div>

            <div class="login-form">
                <form id="form" action="${pageContext.request.contextPath}/login" method="post">
                    <div class="form-group">
                        <input type="text" class="form-control login-field" value="" placeholder="请输入您的账号" name="username" id="login-name">
                        <label class="login-field-icon fui-user" for="login-name" id=""></label>
                    </div>

                    <div class="form-group">
                        <input type="password" class="form-control login-field" value="" placeholder="请输入您的密码" name="password" id="login-pass">
                        <label class="login-field-icon fui-lock" for="login-pass"></label>
                    </div>

                    <label class="checkbox checked" for="_spring_security_remember_me">
                        <input type="checkbox" checked id="_spring_security_remember_me" name="remember_me" data-toggle="checkbox" value="true">两周内自动登录
                    </label>

                    <div class="row">
                        <div class="col-md-6">
                            <a class="btn btn-primary btn-lg btn-block" id="login" href="javascript:void(0);">开始登录</a>
                        </div>
                        <div class="col-md-6">
                            <a class="btn btn-danger btn-lg btn-block" id="lost" href="javascript:void(0);">忘记密码</a>
                        </div>
                    </div>

                    <c:if test="${not empty param.login_error }">
                        <div class="alert alert-warning">
                            <a href="#" class="close" data-dismiss="alert">&times;</a>
                            登录信息:用户名或者密码错误。
                        </div>
                    </c:if>

                    <c:if test="${not empty param.session_error }">
                        <div class="alert alert-warning">
                            <a href="#" class="close" data-dismiss="alert">&times;</a>
                            登录信息:由于您长时间误操作，请重新登录。
                        </div>
                    </c:if>
                </form>
            </div>
        </div>
    </div>

</div>

</body>
</html>
