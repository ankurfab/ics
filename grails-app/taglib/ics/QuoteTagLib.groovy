package ics

class QuoteTagLib {
def quote = {
	def num = Motd.count();
	if (num>0)
	{
	def motdInstance = Motd.findById(new Random().nextInt(num)+1);
    	out << motdInstance?.quote +"<br><br>" + motdInstance?.reference
    }
    else
    	out << "Hare Krishna!"
  }

}
