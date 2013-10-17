create or replace package assert is

	/*  Messages  */
	MSG_REPORT_FINAL_MSG_SUCCESS constant varchar2(10) := 'Sucesso!';

	MSG_REPORT_FINAL_MSG_ERROR constant varchar2(10) := 'Falha!';

	MSG_FOR_TEST_SUCCESSFUL constant varchar2(10) := 'Sucesso';

	MSG_REPORT_TEST_WITH_ERROR constant varchar2(20) := 'Testes com erro';

	MSG_REPORT_TEST_SUCCESSFUL constant varchar2(20) := 'Testes com sucesso';

	MSG_FOR_TEST_WITH_ERROR constant varchar2(10) := 'Erro';

	MSG_FOR_TEST_WITH_NO_NAME constant varchar2(10) := ' - ';

	MSG_REPORT_RESULT constant varchar2(10) := 'Resultado';

	MSG_REPORT_TEST_NAME constant varchar2(10) := 'Teste';

	MSG_REPORT_ORIGIN_NAME constant varchar2(10) := 'Origem';

	MSG_REPORT_LINE constant varchar2(10) := 'Linha';

	MSG_REPORT_EXP_RESULT constant varchar2(20) := 'Resultado esperado';

	MSG_REPORT_ACTUAL_RESULT constant varchar2(20) := 'Resultado obtido';

	MSG_REPORT_DATE constant varchar2(10) := 'Data';

	MSG_REPORT_SCHEMA constant varchar2(20) := 'Usu&aacute;rio';

	MSG_REPORT_SID constant varchar2(10) := 'Oracle SID';

	MSG_REPORT_NOW constant varchar2(10) := 'Agora';

	MSG_DATABASE_ERROR constant varchar2(30) := ' Erro no banco de dados:';

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

	procedure assert_equals
	(
		p_expected  in date,
		p_actual    in date,
		p_test_name in varchar2 default MSG_FOR_TEST_WITH_NO_NAME
	);

	procedure assert_equals
	(
		p_expected  in number,
		p_actual    in number,
		p_test_name in varchar2 default MSG_FOR_TEST_WITH_NO_NAME
	);

	procedure assert_equals
	(
		p_expected  in boolean,
		p_actual    in boolean,
		p_test_name in varchar2 default MSG_FOR_TEST_WITH_NO_NAME
	);

	procedure assert_equals
	(
		p_expected  in pls_integer,
		p_actual    in pls_integer,
		p_test_name in varchar2 default MSG_FOR_TEST_WITH_NO_NAME
	);

	procedure purge_by_session;

	procedure purge_by_owner(p_owner in varchar2 default null);

	procedure generate_report;

end assert;
/
