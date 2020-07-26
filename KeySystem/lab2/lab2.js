    class Mailbox{
       
       constructor(props)
       {
        mail='';
        Bfunc = [];
        Afunc = [];
        Bfcount=0;
        Afcount=0;
      
       }
       
        sendMail(mail){
            let b = true;
            if(this.Bfcount!=0){
                for (let i=0; i<this.Bfcount; i++){
                    if(this.Bfunc[i](mail)===false){
                        b=false;
                    }
                }
                if(b===true){
                    for (let i=0; i < this.Afcount; i++){
                        this.Afunc[i](mail);
                    }
                }
            }
            else{
                console.log(mail)
            }
        }
        beforeSend(...fun){
            this.Bfcount=0;
            if(fun.length!==0) {
                for (let arg of fun){
                    this.Bfunc[this.Bfcount] = arg;
                    this.Bfcount++;
                }
            }
        }
        afterSend(...fun){
            this.Afcount=0;
            if(fun.length!==0){
                for (let arg of fun){
                    this.Afunc[this.Afcount] = arg;
                    this.Afcount++;
                }
            }
            else{
                this.Afunc[this.Afcount] = function(mail){
                    console.log(mail)
                }
            }
        }

    }

    const mailbox = new Mailbox()

    mailbox.beforeSend(function (mail) { 
        return mail !== 'spam'; 
    })
    mailbox.afterSend(function (mail) {
    console.log('Новое сообщение: ' + mail)
    })
    mailbox.sendMail('asdf') 
    mailbox.sendMail('spam')






