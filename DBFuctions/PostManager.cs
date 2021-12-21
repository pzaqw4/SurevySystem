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
        #region Survey
        /// <summary>
        /// 建立問卷
        /// </summary>
        /// <param name="survey"></param>
        public static void CreateSurvey(Survey survey)
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    context.Surveys.Add(survey);
                    context.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(ex);
            }
        }

        /// <summary>
        /// 問卷編號生成
        /// </summary>
        /// <returns></returns>
        public static int GetnewID()
        {
            var list = GetAllPostInfo();
            int id = 0;
            for (int i = 0; i < list.Count; i++)
            {
                if (list[i].ID > id)
                {
                    id = list[i].ID;
                }
            }
            return id += 1;
        }
        #endregion

        #region Question
        /// <summary>
        /// 建立問卷內問題
        /// </summary>
        /// <param name="question"></param>
        public static void CreateQuestion(Question question)
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    context.Questions.Add(question);
                    context.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(ex);
            }
        }
        #endregion
        #region Posting Hall Page Functions
        /// <summary> 從DB取得全部問卷資料後，轉換成Model回傳Handler </summary>
        /// <returns>List PostInfoModel</returns>
        public static List<SurveyInfoModel> GetAllPostInfo()
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    // Get Post From DB View Table
                    var query =
                        (from item in context.Surveys
                         orderby item.ID ascending
                         select item);

                    List<Survey> sourceList = query.ToList();

                    // Check Data Exist
                    if (query != null)
                    {
                        // Write into Model
                        List<SurveyInfoModel> postSource =
                            sourceList.Select(obj => new SurveyInfoModel()
                            {
                                PostID = obj.PostID,
                                ID = obj.ID,
                                Title = obj.Title,
                                Starttime = obj.Starttime.ToString("yyyy - MM - dd"),
                                Endtime = obj.Endtime.ToString("yyyy - MM - dd"),
                                Body = obj.Body,
                                ActType = obj.ActType,
                                Available = obj.Available
                            }).ToList();

                        return postSource;
                    }
                    else
                        return null;
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(ex);
                return null;
            }
        }
        #endregion

        #region Delete Data From DB
        /// <summary>
        /// 刪除問卷
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        public static string DeletePost(Guid pid)
        {
            try
            {
                using (DBModel context = new DBModel())
                {

                    var dbObject =
                        context.Surveys.Where(obj => obj.PostID == pid).FirstOrDefault();
                    var ques =
                        context.Questions.Where(obj => obj.PostID == pid).ToList();  //問題一同被刪除
                    if (dbObject != null)
                    {
                        context.Surveys.Remove(dbObject);
                        context.Questions.RemoveRange(ques);
                        context.SaveChanges();
                        return "Success";
                    }

                    return "fail";
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(ex);
                return "Fail!";
            }
        }
        #endregion

    }
}
