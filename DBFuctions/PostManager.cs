using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DBORM;
using Models;

namespace DBFuctions
{
    public class PostManager
    {
        #region Posting Hall Page Functions
        /// <summary> 從DB取得全部貼文資料後，轉換成Model回傳Handler </summary>
        /// <returns>List PostInfoModel</returns>
        public static List<SurveyInfoModel> GetAllPostInfo()
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    // Get Post From DB View Table
                    var query =
                        (from item in context.Surevies
                         orderby item.Title descending
                         select item);

                    List<Surevy> sourceList = query.ToList();

                    // Check Data Exist
                    if (sourceList != null)
                    {
                        // Write into Model
                        List<SurveyInfoModel> postSource =
                            sourceList.Select(obj => new SurveyInfoModel()
                            {
                                PostID = obj.PostID,
                                Title = obj.Title,
                                Starttime = obj.Starttime.ToString("yyyy-MM-dd HH:mm:ss"),
                                Endtime = obj.Endtime.ToString("yyyy-MM-dd HH:mm:ss"),
                                Body = obj.Body,
                                ActType = obj.ActType,
                                Available = obj.Available
                            }).ToList();

                        return postSource;
                    }
                    else
                    {
                        return null;
                    }
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        #endregion

    }
}
