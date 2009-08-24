/*
 This file is part of Eaws


    Eaws is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.


    Eaws is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.


    You should have received a copy of the GNU General Public License
    along with Eaws.  If not, see <http://www.gnu.org/licenses/>.
        author: azbest.pro (azbest.pro@gmail.com)
*/
package web.data
{
	import mx.collections.ArrayCollection;
	/**Data from CNET*/
	public class DataObjectCNET
	{
		public var editorsChoice:String="";
		public var id:String="";
		public var name:String="";
		public var priceURL:String="";
		public var publishDate:String="";
		public var reviewURL:String="http://www.google.com/search?q="+name;
		public var SKU:String="";
		public var specs:String="";
		public var uid:String="";
		public var categoryID:String="";
		public var categoryXlink:String="";
		public var editorsRatingValue:String="n/a";
		public var editorsRatingOutOf:String="n/a";
		public var editorsStarRatingValue:String="n/a";
		public var editorsStarRatingOutOf:String="n/a";
		public var imageURLs:ArrayCollection= new ArrayCollection();
		public var manufacturerID:String;
		public var manufacturerName:String;
		
public function toString():String{
	
	var  output:String = "";
	output+="editorsChoice="+editorsChoice+"\n"
	+"id="+id+"\n"
	+"name="+name+"\n"
	+"priceURL="+priceURL+"\n"
	+"publishDate="+publishDate+"\n"
	+"reviewURL="+reviewURL+"\n"
	+"SKU="+SKU+"\n"
	+"specs="+specs+"\n"

	+"uid="+uid+"\n"
	+"categoryID="+categoryID+"\n"
	+"categoryXlink="+categoryXlink+"\n"
	+"editorsRatingValue="+editorsRatingValue+"\n"
	+"editorsRatingOutOf="+editorsRatingOutOf+"\n"
	+"imageURLs="+imageURLs.toString()+"\n"
	+"manufacturerID="+manufacturerID+"\n"
	+"manufacturerName="+manufacturerName +"\n";
	
	return output;
}
	
	
		
		
		public function DataObjectCNET()
		{
		}
		/*
		 * 
		 CNETResponse	mx.utils.ObjectProxy (@947f551)	
	object	Object (@94d4f39)	
	realm	"cnet"	
	TechProducts	mx.utils.ObjectProxy (@947f509)	
		numFound	2155 [0x86b]	
		numReturned	3	
		object	Object (@9588089)	
		start	"0"	
		TechProduct	mx.collections.ArrayCollection (@95822c1)	
			[inherited]	
			[0]	mx.utils.ObjectProxy (@947f239)	
				Category	mx.utils.ObjectProxy (@947fd31)	
				EditorsChoice	false	
				EditorsRating	ComplexString (@94e8af1)	
				EditorsStarRating	ComplexString (@94e8c11)	
				id	33061246 [0x1f8797e]	
				ImageURL	mx.collections.ArrayCollection (@9582d01)	
				Manufacturer	mx.utils.ObjectProxy (@947f1f1)	
				Name	"Samsung Instinct"	
				object	Object (@95881a1)	
				PreferredNode	mx.utils.ObjectProxy (@947f1a9)	
				PriceURL	"http://shopper.cnet.com/cell-phones/samsung-instinct/4014-6454_9-33061246.html?tag=api&subj=sh"	
				PublishDate	"2008-06-06 10:11:32.0"	
				ReviewURL	"http://reviews.cnet.com/cell-phones/samsung-instinct/4505-6454_7-33061246.html?tag=api&subj=re"	
				SKU	"SPHM800ZKS"	
				Specs	"Up to 345 min, With digital camera / digital player / FM radio, 0.3 lbs"	
				Topic	mx.utils.ObjectProxy (@947f359)	
				type	null	
				uid	"7EC29A05-9000-330C-B4FB-FFDD8C1C2A4F"	
				xlink:href	"http://api.cnet.com/rest/v1.0/techProduct?productId=33061246&iod=Cbreadcrumb&partKey=22569241417921932475142053432913"	
			[1]	mx.utils.ObjectProxy (@947fce9)	
			[2]	mx.utils.ObjectProxy (@947fb81)	
			source	Array (@94d1b31)	
		type	null	
		uid	"8C23BEBB-9D8C-1582-2044-FFDD4928BEDF"	
	type	null	
	uid	"E9BF3CD1-D2AB-BC67-6A14-FFDD42424E3C"	
	version	1	
		 */

	}
}