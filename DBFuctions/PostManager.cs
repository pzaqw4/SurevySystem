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
        public static List<SurevyInfoModel> GetAllPostInfo()
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    // Get Post From DB View Table
                    var query =
                        (from item in context.Surevies
                         orderby item.Starttime descending
                         select item);


                    List<Surevy> sourceList = query.ToList();

                    // Check Data Exist
                    if (sourceList != null)
                    {
                        // Write into Model
                        List<SurevyInfoModel> postSource =
                            sourceList.Select(obj => new SurevyInfoModel()
                            {
                                PostID = obj.PostID,
                                Title = obj.Title,
                                Starttime = obj.Starttime.ToString("yyyy - MM - dd HH: mm:ss"),
                                Endtime = obj.Endtime.ToString("yyyy - MM - dd HH: mm:ss"),
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


        public static SurevyInfoModel GetOnePostInfo(Guid pid)
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    // get info from DB
                    var query =
                        (from item in context.Surevies
                         where item.PostID == pid
                         select item);

                    List<Surevy> sourceList = query.ToList();

                    // Check Data exist
                    if (sourceList != null)
                    {
                        // write into model
                        List<SurevyInfoModel> postInfo =
                            sourceList.Select(obj => new SurevyInfoModel()
                            {
                                Starttime = obj.Starttime.ToString("yyyy-MM-dd HH:mm:ss"),
                                Title = obj.Title,
                                Body = obj.Body
                            }).ToList();

                        return postInfo[0];
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
    }
}
