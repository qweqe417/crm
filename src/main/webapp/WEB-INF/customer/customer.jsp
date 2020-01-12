<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>客户信息管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/js/theAlert.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/skin/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/skin/js/theAlert.js"></script>
<script>


    function get_date(source){
        var date=new Date(source);
        var year=date.getFullYear();
        var month=formatDate(date.getMonth()+1);
        var day=formatDate(date.getDate());
        return year+"-"+month+"-"+day;
    }

    function formatDate(value){
        if(value<10)
        {
            return "0"+value;
        }else{
            return value;
        }
    }
       function selectAll(){

          var oInputs= $("input[id=id][type=checkbox]");
          $(oInputs).each(function(index,element){
              element.checked=true;
          });

       }

       function unSelect(){
           var oInputs= $("input[id=id][type=checkbox]");
           $(oInputs).each(function(index,element){
                if(element.checked){
                    element.checked=false;
                }else{
                    element.checked=true;
                }
           });
       }

       function deleteCustomer(){

           var selectNum= $("input[id=id][type=checkbox]:checked").length;
           if(selectNum==0){
               theAlert("至少选择一条记录进行删除","alert");
           }else{
               theAlert("您确定要删除这些记录吗？","confirm",function(){
                      //找到被选择记录的id
                      ids="";
                       var oInputs=$("input[id=id][type=checkbox]:checked");
                       $(oInputs).each(function(index,element){
                            ids=ids+$(element).val()+",";
                       });
                      ids=ids.substring(0,ids.length-1);
                      $.ajax({
                          url:"${pageContext.request.contextPath}/cus/deleteCustomer",
                          type:"post",
                          data:{"ids":ids},
                          dataType:"json",
                          cache:false,
                          success:function(data){
                              if(data.status==200){
                                 /* theAlert(data.msg,"alert",function(){
                                       window.location="${pageContext.request.contextPath}/cus/customer";
                                  });*/
                                  alert(data.msg);
                                  window.location="${pageContext.request.contextPath}/cus/customer";
                              }else if(data.status==400){
                                 // theAlert(data.msg,"alert");
                                  alert(data.msg);
                              }
                          }
                      });

               });
           }

       }
       function fristPage(currentPage){
           get_customer(1);
       }

       function prePage(currentPage){
           if(currentPage-1>0){
               get_customer(currentPage-1);
           }else{
               get_customer(currentPage);
           }
       }

       function nextPage(currentPage,totalPage){
           if(currentPage+1>totalPage){
               get_customer(currentPage);
           }else{
               get_customer(currentPage+1);
           }
       }

       function lastPage(totalPage){
           get_customer(totalPage);
       }
       $(function(){
          get_customer(1);

       })

       function get_customer(currentPage){
           $.ajax({
               url:"${pageContext.request.contextPath}/cus/queryCustomer",
               type:"post",
               data:{"currentPage":currentPage},
               dataType:"json",
               cache:false,
               success:function(data){


                   //清除以前的数据
                   $("#content tr:not(:lt(2)):not([id=showData])").remove();
                   $.each(data.records,function(index,element){
                       var tr="<tr align='center' bgcolor=\"#FFFFFF\" onMouseMove=\"javascript:this.bgColor='#FCFDEE';\" onMouseOut=\"javascript:this.bgColor='#FFFFFF';\" height=\"22\" >\n" +
                           "\t<td><input name=\"id\" type=\"checkbox\" id=\"id\" value=\""+element.id+"\" class=\"np\"></td>\n" +
                           "\t<td>"+((data.currentPage-1)*data.pageSize+index+1)+"</td>\n" +
                           "\t<td>"+element.companyperson+"</td>\n" +
                           "\t<td align=\"center\">"+element.comname+"</td>\n" +
                           "\t<td>"+get_date(element.addtime)+"</td>\n" +
                           "\t<td>"+element.comphone+"</td>\n" +
                           "\t<td><a href=\"${pageContext.request.contextPath}/cus/updateCustomerUI?id="+element.id+"\">编辑</a> | <a href=\"customer-look.jsp\">查看详情</a></td>\n" +
                           "</tr>";
                       $("#showData").before(tr);
                   });

                   var cutPageCodeTr="  <tr align=\"right\" bgcolor=\"#EEF4EA\">\n" +
                       "        <td height=\"36\" colspan=\"12\" align=\"center\">\n" +
                       "            <a href=\"javascript:fristPage(1)\">首页</a>&nbsp;&nbsp;&nbsp;&nbsp;\n" +
                       "            <a href=\"javascript:prePage("+data.currentPage+")\">上一页</a>&nbsp;&nbsp;&nbsp;&nbsp;\n" +
                       "            <a href=\"javascript:nextPage("+data.currentPage+","+data.totalPage+")\">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;\n" +
                       "            <a href=\"javascript:lastPage("+data.totalPage+")\">尾页</a>\n" +
                       "        </td>\n" +
                       "    </tr>";
                   $("#showData").after(cutPageCodeTr);
               }
           });
       }

       function searchCustomer(){

               $.ajax({
                   url:"${pageContext.request.contextPath}/cus/searchCustomer",
                   type:"post",
                   data:{"seacherType":$("#seacherType").val(),"keyword":$("#keyword").val(),"orderby":$("#orderby").val()},
                   dataType:"json",
                   cache:false,
                   success:function(data){
                       //清除以前的数据
                       $("#content tr:not(:lt(2)):not([id=showData])").remove();
                        $(data).each(function(index,element){

                            var tr="<tr align='center' bgcolor=\"#FFFFFF\" onMouseMove=\"javascript:this.bgColor='#FCFDEE';\" onMouseOut=\"javascript:this.bgColor='#FFFFFF';\" height=\"22\" >\n" +
                                "\t<td><input name=\"id\" type=\"checkbox\" id=\"id\" value=\""+element.id+"\" class=\"np\"></td>\n" +
                                "\t<td>"+element.id+"</td>\n" +
                                "\t<td>"+element.companyperson+"</td>\n" +
                                "\t<td align=\"center\">"+element.comname+"</td>\n" +
                                "\t<td>"+get_date(element.addtime)+"</td>\n" +
                                "\t<td>"+element.comphone+"</td>\n" +
                                "\t<td><a href=\"${pageContext.request.contextPath}/cus/updateCustomerUI?id="+element.id+"\">编辑</a> | <a href=\"customer-look.jsp\">查看详情</a></td>\n" +
                                "</tr>";
                           $("#showData").before(tr);
                        });
                   }
               });
       }
</script>
</head>
<body leftmargin="8" topmargin="8" background='${pageContext.request.contextPath}/skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
<tr>
 <td height="26" background="${pageContext.request.contextPath}/skin/images/newlinebg3.gif">
  <table width="58%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td >
    当前位置:客户信息管理>>客户信息
 </td>
  <td>
    <input type='button' class="coolbg np" onClick="location='${pageContext.request.contextPath}/cus/customer-add';" value='添加客户信息' />
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<!--  搜索表单  -->
<form name='form3' action='' method='get'>
<input type='hidden' name='dopost' value='' />
<table width='98%'  border='0' cellpadding='1' cellspacing='1' bgcolor='#CBD8AC' align="center" style="margin-top:8px">
  <tr bgcolor='#EEF4EA'>
    <td background='${pageContext.request.contextPath}/skin/images/wbg.gif' align='center'>
      <table border='0' cellpadding='0' cellspacing='0'>
        <tr>
          <td width='90' align='center'>搜索条件：</td>
          <td width='160'>
          <select name='seacherType' id="seacherType" style='width:150'>
          	<option value=1>客户所在公司名称</option>
          	<option value=2>联系人姓名</option>
          </select>
        </td>
        <td width='70'>
          关键字：
        </td>
        <td width='160'>
          	<input type='text' name='keyword' id="keyword" value='' style='width:120px' />
        </td>
        <td width='110'>
    		<select name='orderby' id="orderby" style='width:120px'>
            <option value=1>添加时间</option>
      	</select>
        </td>
        <td>
          &nbsp;&nbsp;&nbsp;<a href="javascript:searchCustomer();"><img src="${pageContext.request.contextPath}/skin/images/frame/search.gif"></a>
        </td>
       </tr>
      </table>
    </td>
  </tr>
</table>
</form>
<!--  内容列表   -->
<form name="form2">

<table id="content" width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="12" background="skin/images/tbg.gif">&nbsp;需求列表&nbsp;</td>
</tr>
<tr align="center" bgcolor="#FAFAF1" height="22">
	<td width="4%">选择</td>
	<td width="6%">序号</td>
	<td width="10%">联系人</td>
	<td width="10%">公司名称</td>
	<td width="8%">添加时间</td>
	<td width="8%">联系电话</td>
	<td width="10%">操作</td>
</tr>

    <!--
<tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22" >
	<td><input name="id" type="checkbox" id="id" value="101" class="np"></td>
	<td>1</td>
	<td>李彦宏</td>
	<td align="center">百度</td>
	<td>2015-02-03</td>
	<td>13257634888</td>
	<td><a href="customer-edit.jsp">编辑</a> | <a href="customer-look.jsp">查看详情</a></td>
</tr>
-->

<tr bgcolor="#FAFAF1" id="showData">
<td height="28" colspan="12">
	&nbsp;
	<a href="javascript:selectAll();" class="coolbg">全选</a>
	<a href="javascript:unSelect();" class="coolbg">反选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="javascript:deleteCustomer();" class="coolbg">&nbsp;删除&nbsp;</a>
	<a href="" class="coolbg">&nbsp;导出Excel&nbsp;</a>
</td>
</tr>
<!--
<tr align="right" bgcolor="#EEF4EA">
	<td height="36" colspan="12" align="center">
	    分页代码
	</td>
</tr>
-->


</table>

</form>
  

</body>
</html>