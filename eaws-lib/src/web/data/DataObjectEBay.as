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
	/**Data object representation of sBay alternative search*/
	public class DataObjectEBay
	{
		
		public function DataObjectEBay()
		{
		}
		public var ViewItemURLForNaturalSearch:String ="http://www.ebay.com";
		public var BuyItNowAvailable:String = "false";
		public var ConvertedBuyItNowPrice :String = "0";
		public var EndTime:String = "n/a";
		public var GalleryURL:String ="http://www.ebay.com";
		public var BidCount:String = "n/a";
		public var ConvertedCurrentPrice :String = "n/a";
		public var ConvertedCurrentPriceNative :String = "n/a";
		public var Title:String = "n/a";
		public function toString():String {
			return "BuyItNowAvailable=" + BuyItNowAvailable+"\n"+
					"ConvertedBuyItNowPrice=" + ConvertedBuyItNowPrice+"\n"+
					"EndTime=" + EndTime+"\n"+
					"GalleryURL=" + GalleryURL+"\n"+
					"BidCount=" + BidCount+"\n"+
					"ConvertedCurrentPrice=" + ConvertedCurrentPrice+"\n"+
					"Title=" + Title+"\n"+
					"ViewItemURLForNaturalSearch="+ViewItemURLForNaturalSearch;
		}
		public function toXML():XML{
			var xml:XML=
			<ebay>
				<Title>{Title}</Title>
				<ViewItemURLForNaturalSearch>{ViewItemURLForNaturalSearch}</ViewItemURLForNaturalSearch>
				<BuyItNowAvailable>{BuyItNowAvailable}</BuyItNowAvailable>
				<ConvertedBuyItNowPrice>{ConvertedBuyItNowPrice}</ConvertedBuyItNowPrice>
				<EndTime>{EndTime}</EndTime>
				<BidCount>{BidCount}</BidCount>
				<ConvertedCurrentPrice>{ConvertedCurrentPrice}</ConvertedCurrentPrice>
				
				<GalleryURL>{GalleryURL}</GalleryURL>
			</ebay>;
			return xml;
		}	 

	}
}