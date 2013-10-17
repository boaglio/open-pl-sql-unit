 create or replace package body assert is

	/** internal constants */
	FLAG_FOR_SUCESS constant varchar2(1) := 'Y';

	FLAG_FOR_ERROR constant varchar2(1) := 'N';

	/** save test result **/
	procedure save_test_result
	(
		p_sid         varchar2,
		p_owner       varchar2,
		p_test_name   varchar2,
		p_nm_origin   varchar2,
		p_ds_type     varchar2,
		p_line        number,
		p_fg_result   varchar2,
		p_ds_expected varchar2,
		p_ds_actual   varchar2
	) is
	begin
		insert into oplu_result
			(id,
			 sid,
			 owner,
			 nm_test,
			 nm_origin,
			 ds_type,
			 line,
			 fg_result,
			 ds_expected,
			 ds_actual)
		values
			(oplu_result_seq.nextval,
			 p_sid,
			 p_owner,
			 p_test_name,
			 p_nm_origin,
			 p_ds_type,
			 p_line,
			 p_fg_result,
			 p_ds_expected,
			 p_ds_actual);
		commit;
	exception
		when others then
			dbms_output.put_line(MSG_DATABASE_ERROR || sqlerrm);
	end;

	/** assert **/
	procedure assert
	(
		p_condition in boolean,
		p_test_name in varchar2 default MSG_FOR_TEST_WITH_NO_NAME
	) is
		v_owner     varchar2(1000);
		v_name      varchar2(1000);
		v_lineno    number;
		v_caller_t  varchar2(1000);
		v_fg_result char(1) := FLAG_FOR_ERROR;
	begin
		OWA_UTIL.who_called_me(v_owner,
				       v_name,
				       v_lineno,
				       v_caller_t);
		if (p_condition)
		then
			v_fg_result := FLAG_FOR_SUCESS;
		end if;
		save_test_result(sys_context('USERENV',
					     'SID'),
				 v_owner,
				 p_test_name,
				 v_name,
				 v_caller_t,
				 v_lineno,
				 v_fg_result,
				 null,
				 null);
	end;

	/** assert false **/
	procedure assert_false
	(
		p_condition in boolean,
		p_test_name in varchar2 default MSG_FOR_TEST_WITH_NO_NAME
	) is
		v_owner     varchar2(1000);
		v_name      varchar2(1000);
		v_lineno    number;
		v_caller_t  varchar2(1000);
		v_fg_result char(1) := FLAG_FOR_ERROR;
	begin
		OWA_UTIL.who_called_me(v_owner,
				       v_name,
				       v_lineno,
				       v_caller_t);
		if (not p_condition)
		then
			v_fg_result := FLAG_FOR_SUCESS;
		end if;
		save_test_result(sys_context('USERENV',
					     'SID'),
				 v_owner,
				 p_test_name,
				 v_name,
				 v_caller_t,
				 v_lineno,
				 v_fg_result,
				 null,
				 null);
	end;

	/** assert equals **/
	procedure assert_equals
	(
		p_expected  in varchar2,
		p_actual    in varchar2,
		p_test_name in varchar2 default MSG_FOR_TEST_WITH_NO_NAME
	) is
		v_owner     varchar2(1000);
		v_name      varchar2(1000);
		v_lineno    number;
		v_caller_t  varchar2(1000);
		v_fg_result char(1) := FLAG_FOR_ERROR;
	begin
		OWA_UTIL.who_called_me(v_owner,
				       v_name,
				       v_lineno,
				       v_caller_t);
		if (p_actual = p_expected)
		then
			v_fg_result := FLAG_FOR_SUCESS;
		end if;
		save_test_result(sys_context('USERENV',
					     'SID'),
				 v_owner,
				 p_test_name,
				 v_name,
				 v_caller_t,
				 v_lineno,
				 v_fg_result,
				 p_expected,
				 p_actual);
	end;

	procedure assert_equals
	(
		p_expected  in date,
		p_actual    in date,
		p_test_name in varchar2 default MSG_FOR_TEST_WITH_NO_NAME
	) is
		v_owner     varchar2(1000);
		v_name      varchar2(1000);
		v_lineno    number;
		v_caller_t  varchar2(1000);
		v_fg_result char(1) := FLAG_FOR_ERROR;
	begin
		OWA_UTIL.who_called_me(v_owner,
				       v_name,
				       v_lineno,
				       v_caller_t);
		if (p_actual = p_expected)
		then
			v_fg_result := FLAG_FOR_SUCESS;
		end if;
		save_test_result(sys_context('USERENV',
					     'SID'),
				 v_owner,
				 p_test_name,
				 v_name,
				 v_caller_t,
				 v_lineno,
				 v_fg_result,
				 to_char(p_expected,
					 'dd/MM/yyyy hh24:mi:ss'),
				 to_char(p_actual,
					 'dd/MM/yyyy hh24:mi:ss'));
	end;

	procedure assert_equals
	(
		p_expected  in number,
		p_actual    in number,
		p_test_name in varchar2 default MSG_FOR_TEST_WITH_NO_NAME
	) is
		v_owner     varchar2(1000);
		v_name      varchar2(1000);
		v_lineno    number;
		v_caller_t  varchar2(1000);
		v_fg_result char(1) := FLAG_FOR_ERROR;
	begin
		OWA_UTIL.who_called_me(v_owner,
				       v_name,
				       v_lineno,
				       v_caller_t);
		if (p_actual = p_expected)
		then
			v_fg_result := FLAG_FOR_SUCESS;
		end if;
		save_test_result(sys_context('USERENV',
					     'SID'),
				 v_owner,
				 p_test_name,
				 v_name,
				 v_caller_t,
				 v_lineno,
				 v_fg_result,
				 to_char(p_expected),
				 to_char(p_actual));
	end;

	procedure assert_equals
	(
		p_expected  in boolean,
		p_actual    in boolean,
		p_test_name in varchar2 default MSG_FOR_TEST_WITH_NO_NAME
	) is
		v_owner     varchar2(1000);
		v_name      varchar2(1000);
		v_lineno    number;
		v_caller_t  varchar2(1000);
		v_fg_result char(1) := FLAG_FOR_ERROR;
		v_actual    varchar2(5) := 'FALSE';
		v_expected  varchar2(6) := 'FALSE';
	begin
		OWA_UTIL.who_called_me(v_owner,
				       v_name,
				       v_lineno,
				       v_caller_t);
		if (p_actual = p_expected)
		then
			v_fg_result := FLAG_FOR_SUCESS;
		end if;
		if (p_actual)
		then
			v_actual := 'TRUE';
		end if;
		if (p_expected)
		then
			v_expected := 'TRUE';
		end if;
		save_test_result(sys_context('USERENV',
					     'SID'),
				 v_owner,
				 p_test_name,
				 v_name,
				 v_caller_t,
				 v_lineno,
				 v_fg_result,
				 v_expected,
				 v_actual);
	end;

	procedure assert_equals
	(
		p_expected  in pls_integer,
		p_actual    in pls_integer,
		p_test_name in varchar2 default MSG_FOR_TEST_WITH_NO_NAME
	) is
		v_owner     varchar2(1000);
		v_name      varchar2(1000);
		v_lineno    number;
		v_caller_t  varchar2(1000);
		v_fg_result char(1) := FLAG_FOR_ERROR;
	begin
		OWA_UTIL.who_called_me(v_owner,
				       v_name,
				       v_lineno,
				       v_caller_t);
		if (p_actual = p_expected)
		then
			v_fg_result := FLAG_FOR_SUCESS;
		end if;
		save_test_result(sys_context('USERENV',
					     'SID'),
				 v_owner,
				 p_test_name,
				 v_name,
				 v_caller_t,
				 v_lineno,
				 v_fg_result,
				 to_char(p_expected),
				 to_char(p_actual));
	end;

	/** purge by owner **/
	procedure purge_by_owner(p_owner in varchar2 default null) is
		v_owner    varchar2(1000);
		v_name     varchar2(1000);
		v_lineno   number;
		v_caller_t varchar2(1000);
	begin
		if (p_owner is null)
		then
			OWA_UTIL.who_called_me(v_owner,
					       v_name,
					       v_lineno,
					       v_caller_t);
		else
			v_owner := p_owner;
		end if;
		dbms_output.put_line('Purging results by schema: ' ||
				     v_owner);
		delete oplu_result where owner = upper(v_owner);
		dbms_output.put_line('Deleted rows = ' || sql%rowcount);
		commit;
	exception
		when others then
			dbms_output.put_line(MSG_DATABASE_ERROR || sqlerrm);
	end;

	/** purge by session  **/
	procedure purge_by_session is
		v_owner    varchar2(1000);
		v_name     varchar2(1000);
		v_lineno   number;
		v_caller_t varchar2(1000);
	begin
		OWA_UTIL.who_called_me(v_owner,
				       v_name,
				       v_lineno,
				       v_caller_t);
		dbms_output.put_line('Purging results by session: ' ||
				     v_owner);
		delete oplu_result
		where  owner = v_owner and
		       sid = sys_context('USERENV',
					 'SID');
		dbms_output.put_line('Deleted rows = ' || sql%rowcount);
		commit;
	exception
		when others then
			dbms_output.put_line(MSG_DATABASE_ERROR || sqlerrm);
	end;

	/** HTML header **/
	procedure report_header is
	begin
		htp.p('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<style type="text/css">
H1 {
	font-family: Georgia, serif;
	font-size: 18px;
	font-weight: bold;
	color: #039;
	letter-spacing: 1.4px;
	border-bottom: solid 1px #039; 
}

H2 {
	font-family: "Trebuchet MS", Helvetica, sans-serif
	font-size: 16px;
	color: #039;
	letter-spacing: 1.4px;
	border-bottom: solid 1px #039; 
}

#resultbox
{
	font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
	font-size: 12px;
	margin: 45px;
	width: 90%;
	text-align: left;
	
}
#resultbox th
{
	font-size: 13px;
	font-weight: normal;
	padding: 8px;
	background: #b9c9fe;
	border-top: 4px solid #aabcfe;
	border-bottom: 1px solid #fff;
	color: #039;
}
.green
{
 	padding: 8px;
	font-size: 13px;
	background: #00ff00; 
	border-bottom: 1px solid #00ff00;
	border-top: 4px solid transparent;
	color: #000;	
 
}
.red
{
	padding: 8px;
	font-size: 13px;
	background: #ff0c0c; 
	border-bottom: 1px solid #fff;
	color: #fff;
	border-top: 4px solid transparent;
 }

#resultbox tr:hover td
{
	background: #fff;
	color: #339;
}

#resultbox tr { border-collapse: separate;border-spacing:15em }
.final_msg_red {font-family:"Times New Roman",Times,serif;font-size:350%;color:red}
.final_msg_green {font-family:"Times New Roman",Times,serif;font-size:350%;color:green}
</style>
</head>
<body>
 <center>
 <h1>Open PL/SQL Unit</h1> 
 <table id="resultbox">
    <thead>
    	<tr>
       	    <th>' || MSG_REPORT_RESULT ||
		      '</th>
       	    <th>' || MSG_REPORT_TEST_NAME ||
		      '</th>
	    <th>' || MSG_REPORT_ORIGIN_NAME || '</th>
	    <th>' || MSG_REPORT_LINE || '</th>
	    <th>' || MSG_REPORT_EXP_RESULT || '</th>
	    <th>' || MSG_REPORT_ACTUAL_RESULT || '</th>
	    <th>' || MSG_REPORT_DATE || '</th>	
	</tr>
    </thead>
    <tbody>');
	end;

	/** HTML footer **/
	procedure report_footer
	(
		p_owner         varchar2,
		p_sid           varchar2,
		p_total_success pls_integer,
		p_total_error   pls_integer
	) is
		v_total_tests pls_integer;
	begin
		v_total_tests := p_total_success + p_total_error;
		htp.p('</tbody></table>');
		htp.p('<h2><font color=black>' || MSG_REPORT_SCHEMA ||
		      ':</font> ' || p_owner);
		htp.p('&nbsp;&nbsp;<font color=black>' || MSG_REPORT_SID ||
		      ':</font> ' || p_sid);
		htp.p('&nbsp;&nbsp;<font color=black>' || MSG_REPORT_NOW ||
		      ':</font> ' ||
		      to_char(sysdate,
			      'dd/MM/yyyy hh24:mi:ss') || '</h2>');
		htp.p('<h2><font color=black>' ||
		      MSG_REPORT_TEST_SUCCESSFUL || ':</font> ' ||
		      p_total_success || ' / ' || v_total_tests || '</h2>');
		htp.p('<h2><font color=black>' ||
		      MSG_REPORT_TEST_WITH_ERROR || ':</font> ' ||
		      p_total_error || ' / ' || v_total_tests || '</h2>');
		if (p_total_error = 0)
		then
			htp.p('<p class="final_msg_green">' ||
			      MSG_REPORT_FINAL_MSG_SUCCESS || '</p>');
		else
			htp.p('<p class="final_msg_red">' ||
			      MSG_REPORT_FINAL_MSG_ERROR || '</p>');
		end if;
		htp.p('</center></body></html>');
	end;

	/** generate HTML report **/
	procedure generate_report is
		v_total_success pls_integer := 0;
		v_total_error   pls_integer := 0;
		v_owner         varchar2(1000);
		v_name          varchar2(1000);
		v_lineno        number;
		v_caller_t      varchar2(1000);
		cursor report
		(
			p_sid   varchar2,
			p_owner varchar2
		) is
			select ds_type,
			       nm_test,
			       nm_origin,
			       line,
			       fg_result,
			       ds_expected,
			       ds_actual,
			       dt_included
			from   oplu_result
			where  sid = p_sid and
			       owner = p_owner
			order  by id;
	begin
		report_header;
		OWA_UTIL.who_called_me(v_owner,
				       v_name,
				       v_lineno,
				       v_caller_t);
		for rec in report(sys_context('USERENV',
					      'SID'),
				  v_owner)
		loop
			if (rec.fg_result = FLAG_FOR_SUCESS)
			then
				htp.p('<tr class="green">');
				htp.p('<td>&nbsp;' ||
				      MSG_FOR_TEST_SUCCESSFUL ||
				      '&nbsp;</td>');
				v_total_success := v_total_success + 1;
			else
				htp.p('<tr class="red">');
				htp.p('<td>&nbsp;' ||
				      MSG_FOR_TEST_WITH_ERROR ||
				      '&nbsp;</td>');
				v_total_error := v_total_error + 1;
			end if;
			htp.p('<td>&nbsp;' || rec.nm_test || '&nbsp;</td>');
			htp.p('<td>&nbsp;' || rec.nm_origin ||
			      '&nbsp;(&nbsp;' || rec.ds_type ||
			      '&nbsp;)&nbsp;</td>');
			htp.p('<td>&nbsp;' || rec.line || '&nbsp;</td>');
			htp.p('<td>&nbsp;' || rec.ds_expected ||
			      '&nbsp;</td>');
			htp.p('<td>&nbsp;' || rec.ds_actual ||
			      '&nbsp;</td>');
			htp.p('<td>&nbsp;' ||
			      to_char(rec.dt_included,
				      'dd/MM/yyyy hh24:mi:ss') || '</td>');
			htp.p('</tr>');
		end loop;
		report_footer(v_owner,
			      sys_context('USERENV',
					  'SID'),
			      v_total_success,
			      v_total_error);
	exception
		when others then
			dbms_output.put_line(MSG_DATABASE_ERROR || sqlerrm);
	end;

end assert;
/
