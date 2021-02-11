--!strict

local core: any = {}

core.tickets = {

	economy = {

		posRef = 1;

		name = "Economy Class";

		id = 0;

		oldId = {

			{id = 0, check = false};

		};

		free = true;

		checkinImage = 4650950361;

		checkinDescription = "Hello world!";

	};

	priority = {

		posRef = 2;

		name = "Priority Class";

		id = 412190013;

		oldId = {

			{id = 0, check = false};

		};

		free = false;

		checkinImage = 68605953;

		checkinDescription = "Hello world!";

	};

	first = {

		posRef = 3;

		name = "First Class";

		id = 6252213343;

		oldId = {

			{id = 0, check = false};

		};

		free = false;

		checkinImage = 6252242625;

		checkinDescription = (

[[Got called racist in greggs earlier lads
> tell us what happened lad
I called racist in greggs
> ye but why
>> i was being racist
> in greggs?
>> yeah it was in greggs]]

		);

	};

	investorSilver = {

		posRef = 4;

		name = "Silver Investor";

		id = 218878415;

		oldId = {

			{id = 0, check = false};

		};

		free = false;

		checkinImage = 3355212974;

		checkinDescription = "Hello world!";

	};

	investorGold = {

		posRef = 5;

		name = "Gold Investor";

		id = 218874232;

		oldId = {

			{id = 0, check = false};

		};

		free = false;

		checkinImage = 446868348;

		checkinDescription = "Hello world!";

	};

	investorPlat = {

		posRef = 6;

		name = "Platinum Investor";

		id = 4934539728;

		oldId = {

			{id = 0, check = false};

		};

		free = false;

		checkinImage = 6274190863;

		checkinDescription = "Hello world!";

	};

}

return core