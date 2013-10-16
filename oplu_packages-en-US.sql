create or replace package assert is

	/*  Messages  */
	MSG_REPORT_FINAL_MSG_SUCCESS constant varchar2(10) := 'Success!';

	MSG_REPORT_FINAL_MSG_ERROR constant varchar2(10) := 'Fail!';

	MSG_FOR_TEST_SUCCESSFUL constant varchar2(10) := 'Success';

	MSG_REPORT_TEST_WITH_ERROR constant varchar2(20) := 'Tests with error';

	MSG_REPORT_TEST_SUCCESSFUL constant varchar2(20) := 'Successful tests';

	MSG_FOR_TEST_WITH_ERROR constant varchar2(10) := 'Error';

	MSG_FOR_TEST_WITH_NO_NAME constant varchar2(10) := ' - ';

	MSG_REPORT_RESULT constant varchar2(10) := 'Result';

	MSG_REPORT_TEST_NAME constant varchar2(10) := 'Test';

	MSG_REPORT_ORIGIN_NAME constant varchar2(10) := 'Origin';

	MSG_REPORT_LINE constant varchar2(10) := 'Line';

	MSG_REPORT_EXP_RESULT constant varchar2(20) := 'Expected result';

	MSG_REPORT_ACTUAL_RESULT constant varchar2(20) := 'Actual result';

	MSG_REPORT_DATE constant varchar2(10) := 'Date';

	MSG_REPORT_SCHEMA constant varchar2(20) := 'User';

	MSG_REPORT_SID constant varchar2(10) := 'Oracle SID';

	MSG_REPORT_NOW constant varchar2(10) := 'Now';

	MSG_DATABASE_ERROR constant varchar2(30) := ' Database error:';

	/* public units */
	procedure assert
	(
		p_condition in boolean,
		p_test_name in varchar2 default MSG_FOR_TEST_WITH_NO_NAME
	);

	procedure assert_false
	(
		p_condition in boolean,
		p_test_name in varchar2 default MSG_FOR_TEST_WITH_NO_NAME
	);

	procedure assert_equals
	(
		p_expected  in varchar2,
		p_actual    in varchar2,
		p_test_name in varchar2 default MSG_FOR_TEST_WITH_NO_NAME
	);

	procedure purge_by_session;

	procedure purge_by_owner(p_owner in varchar2 default null);

	procedure generate_report;

end assert;
/
