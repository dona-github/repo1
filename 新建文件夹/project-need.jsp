<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>需求分析管理</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-3.1.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/moment.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
</head>
<body leftmargin="8" topmargin="8" background='${pageContext.request.contextPath}/skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
    <tr>
        <td height="26" background="${pageContext.request.contextPath}/skin/images/newlinebg3.gif">
            <table width="58%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        当前位置:项目管理>>需求分析管理
                    </td>
                    <td>
                        <input type='button' class="coolbg np" onClick="location='${pageContext.request.contextPath}/project-need-add.jsp';"
                               value='添加新项目需求'/>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!--  搜索表单  -->
<form name='form3' id="form3" action='javascript:void(0)' method='get'>
    <input type='hidden' name='dopost' value=''/>
    <table width='98%' border='0' cellpadding='1' cellspacing='1' bgcolor='#CBD8AC' align="center"
           style="margin-top:8px">
        <tr bgcolor='#EEF4EA'>
            <td background='${pageContext.request.contextPath}/skin/images/wbg.gif' align='center'>
                <table border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td width='90' align='center'>搜索条件：</td>
                        <td width='160'>
                            <select name='cid' id="cid" style='width:150'>
                                <option value='0'>选择类型...</option>
                                <option value='1'>项目名称</option>
                                <option value='2'>标题</option>
                            </select>
                        </td>
                        <td width='70'>
                            关键字：
                        </td>
                        <td width='160'>
                            <input type='text' name='keyword' id="keyword" style='width:120px'/>
                        </td>
                        <td width='110'>
                            <select name='orderBy' id="orderBy" style='width:120px'>
                                <option value='id'>排序...</option>
                                <option value='addtime'>添加时间</option>
                                <option value='updatetime'>修改时间</option>
                            </select>
                        </td>
                        <td>
                            &nbsp;&nbsp;&nbsp;<input name="imageField" type="image" onclick="sousuo()"
                                                     src="${pageContext.request.contextPath}/skin/images/frame/search.gif"
                                                     width="45" height="20" border="0" class="np"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
<!--  内容列表   -->
<form name="form2">

    <table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center"
           style="margin-top:8px">
        <tr bgcolor="#E7E7E7">
            <td height="24" colspan="12" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;需求列表&nbsp;</td>
        </tr>
        <tr align="center" bgcolor="#FAFAF1" height="22">
            <td width="4%">选择</td>
            <td width="6%">序号</td>
            <td width="10%">标题</td>
            <td width="10%">项目名称</td>
            <td width="8%">添加时间</td>
            <td width="8%">修改时间</td>
            <td width="10%">操作</td>
        </tr>
        <C:forEach items="${list}" var="analysis" varStatus="i">
            <tr name="deltr" align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <td><input name="id" type="checkbox" id="id" value="${analysis.id}" class="np"></td>
                <td>${i.count}</td>
                <td>${analysis.proname}</td>
                <td align="center"><a href=''><u>${analysis.title}</u></a></td>
                <td>
                    <fmt:formatDate value="${analysis.addtime}" pattern="yyyy-MM-dd"></fmt:formatDate>
                </td>
                <td>
                    <fmt:formatDate value="${analysis.updatetime}" pattern="yyyy-MM-dd"></fmt:formatDate>
                </td>
                <td><a href="${pageContext.request.contextPath}/ana/updateAnalysisById?id=${analysis.id}">编辑</a> | <a href="${pageContext.request.contextPath}/ana/findAnalysisById?id=${analysis.id}">查看详情</a></td>
            </tr>
        </C:forEach>
        <tr bgcolor="#FAFAF1" id="dingwei">
            <td height="28" colspan="12">
                &nbsp;
                <a href="javascript:qx()" class="coolbg">全选</a>
                <a href="javascript:fx()" class="coolbg">反选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="javascript:sc()" class="coolbg">&nbsp;删除&nbsp;</a>
                <a href="" class="coolbg">&nbsp;导出Excel&nbsp;</a>
            </td>
        </tr>
        <tr align="right" bgcolor="#EEF4EA">
            <td height="36" colspan="12" align="center"><!--翻页代码 --></td>
        </tr>
    </table>
</form>
</body>
<script type="text/javascript">
    function qx(){
        $('[name="id"]').prop("checked","checked");
    };
    function fx(){
        $('[name="id"]').each(function () {
            var result = $(this).prop("checked");
            $(this).prop("checked",!result)
        });
    };
    function sc() {
        // 非空验证
        if($('[name="id"]:checked').length == 0){
            alert("请选择要删除的标题！");
            return;
        }
        var ids =[];//拼接所有要删除的选项的id
        var comname = "";//拼接所有要删除的项目名称
        var input =  $('[name="id"]:checked');
        $('[name="id"]:checked').each(function(){
            ids+=","+$(this).val();
            comname += "," +$(this).parent().parent().find("td:eq(2)").text();
        });
        ids = ids.substr(1);
        comname = comname.substr(1);
        //删除提示
        if(confirm("确认要标题项目为:\r"+comname)){
            $.ajax({
                type:"post",
                url:"${pageContext.request.contextPath}/ana/del",
                data:{"_method":"delete","ids":ids},
                success:function (msg) {
                    if(msg.statusCode == 200){
                        alert(msg.message);
                        input.each(function () {
                            $(this).parent().parent().remove();
                        });
                    }else{
                        alert(msg.message);
                    }
                }
            })
        }
    }
    function sousuo() {
        var cid = $("#cid").val();
        var keyword = $("#keyword").val();
        var orderBy = $("#orderBy").val();
        $.ajax({
            url:"${pageContext.request.contextPath}/ana/tiaojian",
            type:"get",
            data:{"cid":cid,"keyword":keyword,"orderBy":orderBy},
            success: function (msg) {
                $("tr[name=deltr]").remove();
                $(msg).each(function(index,item) {
                    var tr = "<tr name='deltr' align='center' bgcolor='#FFFFFF' onMouseMove='javascript:this.bgColor='#FCFDEE';'onMouseOut='javascript:this.bgColor='#FFFFFF';' height='22'>"
                    +" <td><input name='id' type='checkbox' id='id' value='"+item.id+"' class='np'></td>"
                    +" <td>"+(index+1)+"</td>"
                    +" <td>"+item.proname+"</td>"
                    +" <td align='center'><a href=''><u>"+item.title+"</u></a></td>"
                    +" <td>"+moment(item.addtime).format('YYYY-MM-DD')+"</td>"
                    +" <td>"+moment(item.updatetime).format('YYYY-MM-DD')+"</td>"
                    +" <td><a href='${pageContext.request.contextPath}/ana/updateAnalysisById?id=${analysis.id}'>编辑</a> | <a href='${pageContext.request.contextPath}/ana/findAnalysisById?id=${analysis.id}'>查看详情</a></td></tr>"
                    $("#dingwei").before(tr);
                })
            }
        })
    };
</script>
</html>