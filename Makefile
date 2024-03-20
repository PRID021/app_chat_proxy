
perform:
	flutter test --coverage

report:
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html