// const _0x5517da=_0x55aa;function _0x55aa(_0x2b0d72,_0x56693a){const _0x6e5745=_0x6e57();return _0x55aa=function(_0x55aa20,_0x44ffa7){_0x55aa20=_0x55aa20-0x1b3;let _0x40d994=_0x6e5745[_0x55aa20];return _0x40d994;},_0x55aa(_0x2b0d72,_0x56693a);}(function(_0x113b0e,_0xa31895){const _0x3026a8=_0x55aa,_0x45d3ef=_0x113b0e();while(!![]){try{const _0x277843=-parseInt(_0x3026a8(0x1c7))/0x1+-parseInt(_0x3026a8(0x1bb))/0x2+parseInt(_0x3026a8(0x1c5))/0x3+-parseInt(_0x3026a8(0x1b6))/0x4+parseInt(_0x3026a8(0x1c2))/0x5*(parseInt(_0x3026a8(0x1c9))/0x6)+parseInt(_0x3026a8(0x1d0))/0x7+parseInt(_0x3026a8(0x1cb))/0x8;if(_0x277843===_0xa31895)break;else _0x45d3ef['push'](_0x45d3ef['shift']());}catch(_0x1a55fc){_0x45d3ef['push'](_0x45d3ef['shift']());}}}(_0x6e57,0xc8ddc));function _0x6e57(){const _0x427557=['267104AFgTKz','createTransport','\x20[*]\x20Aguardando\x20mensagens\x20na\x20fila\x20%s.\x20Para\x20sair\x20use:\x20CTRL+C','content','dotenv','assertQueue','PORT','5128315StYXlQ','USER','sendMail','1965141pjKgog','log','1186451RZZRge','\x20[x]\x20Enviando\x20email\x20=>\x20%s','6poglOE','toString','4785096OsReuM','AMQP_URL','config','parse','env','2022328rfJbkF','connect','PASS','amqplib/callback_api','1700000oCfTnX','HOST','consume','createChannel','html'];_0x6e57=function(){return _0x427557;};return _0x6e57();}const nodemailer=require('nodemailer');require(_0x5517da(0x1bf))[_0x5517da(0x1cd)]();var amqp=require(_0x5517da(0x1b5));const transporter=nodemailer[_0x5517da(0x1bc)]({'host':process[_0x5517da(0x1cf)][_0x5517da(0x1b7)],'port':process[_0x5517da(0x1cf)][_0x5517da(0x1c1)],'auth':{'user':process[_0x5517da(0x1cf)][_0x5517da(0x1c3)],'pass':process[_0x5517da(0x1cf)][_0x5517da(0x1b4)]}});amqp[_0x5517da(0x1b3)](process[_0x5517da(0x1cf)][_0x5517da(0x1cc)],function(_0x63d09f,_0x4f850f){const _0x5de648=_0x5517da;_0x4f850f[_0x5de648(0x1b9)](function(_0x7c071a,_0x59bf11){const _0x44b7bc=_0x5de648,_0x52c6b1=process[_0x44b7bc(0x1cf)]['QUEUE_NAME'];_0x59bf11[_0x44b7bc(0x1c0)](_0x52c6b1,{'durable':!![]}),_0x59bf11['prefetch'](0x1),console[_0x44b7bc(0x1c6)](_0x44b7bc(0x1bd),_0x52c6b1),_0x59bf11[_0x44b7bc(0x1b8)](_0x52c6b1,function(_0x47f3d5){const _0x2e851e=_0x44b7bc;var _0x511740=JSON[_0x2e851e(0x1ce)](_0x47f3d5[_0x2e851e(0x1be)][_0x2e851e(0x1ca)]());console[_0x2e851e(0x1c6)](_0x511740);const _0x364992={'from':'parceria@buger-eats.qa.ninja','to':_0x511740['email'],'subject':_0x511740['subject'],'html':_0x511740[_0x2e851e(0x1ba)]};transporter[_0x2e851e(0x1c4)](_0x364992,function(_0x3c3356,_0x19fb6b){const _0xf912bd=_0x2e851e;_0x3c3356?console[_0xf912bd(0x1c6)](_0x3c3356):console[_0xf912bd(0x1c6)](_0xf912bd(0x1c8),_0x47f3d5['content'][_0xf912bd(0x1ca)]());});},{'noAck':!![]});});});

const nodemailer = require('nodemailer');
const amqp = require('amqplib/callback_api');
require('dotenv').config();

// Configuração do transportador de e-mails
const transporter = nodemailer.createTransport({
    host: process.env.HOST,
    port: process.env.PORT,
    auth: {
        user: process.env.USER,
        pass: process.env.PASS
    }
});

// Conectando ao RabbitMQ
amqp.connect(process.env.AMQP_URL, function (error, connection) {
    if (error) {
        throw error;
    }
    connection.createChannel(function (error, channel) {
        if (error) {
            throw error;
        }

        const queue = process.env.QUEUE_NAME;
        channel.assertQueue(queue, { durable: true });
        channel.prefetch(1);

        console.log(`[*] Aguardando mensagens na fila ${queue}. Para sair use: CTRL+C`);

        channel.consume(queue, function (msg) {
            if (msg !== null) {
                let emailData = JSON.parse(msg.content.toString());
                console.log(emailData);

                const mailOptions = {
                    from: 'parceria@buger-eats.qa.ninja',
                    to: emailData.email,
                    subject: emailData.subject,
                    html: emailData.html
                };

                transporter.sendMail(mailOptions, function (error, info) {
                    if (error) {
                        console.log(error);
                    } else {
                        console.log(`[x] Enviando email => ${emailData.content.toString()}`);
                    }
                });
            }
        }, { noAck: true });
    });
});
