global.rootDir = __dirname;

const schedule = require("node-schedule");
const football1 = require('./class/football1');
const football2 = require('./class/football2');
const football3 = require('./class/football3');
const football4 = require('./class/football4');
const basketball = require('./class/basketball');
require('./auxs/Error.Extensions');



function main() {
    try {
        football1.get();
        football2.get();
        football3.get();
        football4.get();
        basketball.get();
        const j = schedule.scheduleJob('0 0 */1 * * *', function () {
            football1.get();
            football2.get();
            football3.get();
            football4.get();
        	basketball.get();
        });
    }catch (e){
        console.log(e);
        if (!!e.code)  console.error('   Code : ' + e.code);
        console.error('Message : '+e.message);
        if (!!e.hints)  console.error("  Hints : " + e.hints);
    }
}

main();