UserCaptureApp
This application captures user data from an external API, stores it in a PostgreSQL database, and provides a user interface to view the data.

Getting Started
	Prerequisites
		Ruby: Ensure Ruby version 3.2.2 is installed. You can install Ruby using your preferred method, such as RVM or rbenv.

		Rails: Install Rails version 7.1.3 by running gem install rails -v 7.1.3.

		PostgreSQL: Ensure PostgreSQL is installed on your system. You can download and install PostgreSQL from the official website or use a package manager.

Installation
	1- Clone this repository to your local machine.
			git clone <repository_url>
	2- Navigate to the project directory.
		 	cd UserCaptureApp
	3- bundle install

Database Setup
	Run the following commands to create and set up the database:
		rails db:setup
	This will create the database, load the schema, and seed initial data if provided.

Usage
 	Scheduled Jobs
		Two jobs are scheduled to run periodically:

		FetchAndStoreUsersJob: Fetches user data from an external API and stores it in the database. This job runs every hour.

		TabulateDailyRecordsJob: Tabulates daily records by aggregating user data. This job runs at the end of each day.

		To manually trigger the FetchAndStoreUsersJob, run the following command:
		1- rails c

		2- FetchAndStoreUsersJob.perform_now

Viewing Records
	Once the jobs have fetched and stored data, you can view records through the user interface.