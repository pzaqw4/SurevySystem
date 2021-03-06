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


        /// <summary> 從資料庫取得問卷資訊 </summary>
        /// <returns></returns>
        public static SurveyInfoModel GetOnePostInfo(Guid pid)
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    // get info from DB
                    var query =
                        (from item in context.Surveys
                         where item.PostID == pid
                         select item);

                    List<Survey> sourceList = query.ToList();

                    // Check Data exist
                    if (sourceList != null)
                    {
                        // write into model
                        List<SurveyInfoModel> postInfo =
                            sourceList.Select(obj => new SurveyInfoModel()
                            {
                                Title = obj.Title,
                                Body = obj.Body,
                                Starttime = (obj.Starttime).ToString("yyyy-MM-dd"),
                                Endtime = (obj.Endtime).ToString("yyyy-MM-dd")
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
                Logger.WriteLog(ex);
                return null;
            }
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
        /// <summary>
        /// 取得問題資料
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        public static List<QuestionInfoModel> GetAllQuestion(Guid pid)
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    // get info from DB
                    var query =
                        (from item in context.Questions
                         where item.PostID == pid
                         select item);

                    List<Question> sourceList = query.ToList();

                    // Check Data exist
                    if (sourceList != null)
                    {
                        // write into model
                        List<QuestionInfoModel> postInfo =
                            sourceList.Select(obj => new QuestionInfoModel()
                            {
                                PostID = obj.PostID,
                                QuID = obj.QuID,
                                Caption = obj.Caption,
                                Type = obj.Type,
                                Nullable = obj.Nullable,
                                Ans = obj.Ans
                            }).ToList();

                        return postInfo;
                    }
                    else
                    {
                        return null;
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(ex);
                return null;
            }
        }
        #endregion

        #region Answer

        public static void CreateAnswer(Answer answer)
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    context.Answers.Add(answer);
                    context.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(ex);
            }
        }

        public static AnswerInfoModel GetOneAnswerInfo(int aid)
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    // get info from DB
                    var query =
                        (from item in context.Answers
                         where item.AnsID == aid
                         select item);

                    List<Answer> sourceList = query.ToList();

                    // Check Data exist
                    if (sourceList != null)
                    {
                        // write into model
                        List<AnswerInfoModel> postInfo =
                            sourceList.Select(obj => new AnswerInfoModel()
                            {
                                AnsID = obj.AnsID,
                                A_UserName = obj.A_UserName,
                                A_UserPhone = obj.A_UserPhone,
                                A_UserEmail = obj.A_UserEmail,
                                A_UserAge = obj.A_UserAge,
                                Answer1 = obj.Answer1,
                                CreateTime = obj.CreateTime.ToString("F"),
                                PostID = obj.PostID
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
                Logger.WriteLog(ex);
                return null;
            }
        }
        public static List<AnswerInfoModel> GetAnswerInfoByPID(Guid pid)
        {
            try
            {
                using (DBModel context = new DBModel())
                {

                    var query =
                        (from item in context.Answers
                         where item.PostID == pid
                         select item);

                    List<Answer> sourceList = query.ToList();

                    if (query != null)
                    {
                        List<AnswerInfoModel> postSource =
                            sourceList.Select(obj => new AnswerInfoModel()
                            {
                                AnsID = obj.AnsID,
                                A_UserName = obj.A_UserName,
                                A_UserPhone = obj.A_UserPhone,
                                A_UserEmail = obj.A_UserEmail,
                                A_UserAge = obj.A_UserAge,
                                Answer1 = obj.Answer1,
                                CreateTime = obj.CreateTime.ToString("F"),
                                PostID = obj.PostID
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

        #region MixQuestions
        /// <summary>
        /// 建立問題集內容
        /// </summary>
        /// <param name="qusMixModel"></param>
        public static void CreateMixQus(MixQu mixQu)
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    context.MixQus.Add(mixQu);
                    context.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(ex);
            }
        }

        public static void UpDateMixQus(MixQu mixQu)
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    var dbObject =
                       context.MixQus.Where(obj => obj.QuID == mixQu.QuID).FirstOrDefault();

                    if (dbObject != null)
                    {
                        dbObject.Caption = mixQu.Caption;
                        dbObject.Nullable = mixQu.Nullable;
                        dbObject.Ans = mixQu.Ans;
                        dbObject.Type = mixQu.Type;

                        context.SaveChanges();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(ex);
            }
        }
        public static QusMixModel GetOneMixInfo(int quid)
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    // get info from DB
                    var query =
                        (from item in context.MixQus
                         where item.QuID == quid
                         select item);

                    List<MixQu> sourceList = query.ToList();

                    // Check Data exist
                    if (sourceList != null)
                    {
                        // write into model
                        List<QusMixModel> postInfo =
                            sourceList.Select(obj => new QusMixModel()
                            {
                                QuID = obj.QuID,
                                Caption = obj.Caption,
                                Type = obj.Type,
                                Nullable = obj.Nullable,
                                Ans = obj.Ans
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
                Logger.WriteLog(ex);
                return null;
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

        public static List<AnswerInfoModel> GetAllAnswerInfo()
        {
            try
            {
                using (DBModel context = new DBModel())
                {

                    var query =
                        (from item in context.Answers
                         orderby item.CreateTime ascending
                         select item);

                    List<Answer> sourceList = query.ToList();

                    if (query != null)
                    {
                        List<AnswerInfoModel> postSource =
                            sourceList.Select(obj => new AnswerInfoModel()
                            {
                                AnsID = obj.AnsID,
                                A_UserName = obj.A_UserName,
                                A_UserPhone = obj.A_UserPhone,
                                A_UserEmail = obj.A_UserEmail,
                                A_UserAge = obj.A_UserAge,
                                Answer1 = obj.Answer1,
                                CreateTime = obj.CreateTime.ToString("F"),
                                PostID = obj.PostID
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

        public static List<QusMixModel> GetQusMixInfo()
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    // Get Post From DB View Table
                    var query =
                        (from item in context.MixQus
                         orderby item.QuID ascending
                         select item);

                    List<MixQu> sourceList = query.ToList();

                    // Check Data Exist
                    if (query != null)
                    {
                        // Write into Model
                        List<QusMixModel> postSource =
                            sourceList.Select(obj => new QusMixModel()
                            {                              
                                QuID = obj.QuID,
                                Caption = obj.Caption,
                                Type = obj.Type,
                                Nullable = obj.Nullable,
                                Ans = obj.Ans
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

                    return "Fail";
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(ex);
                return "Fail!";
            }
        }
        public static string DeleteMixQus(int quid)
        {
            try
            {
                using (DBModel context = new DBModel())
                {

                    var dbObject =
                        context.MixQus.Where(obj => obj.QuID == quid).FirstOrDefault();

                    if (dbObject != null)
                    {
                        context.MixQus.Remove(dbObject);
                        context.SaveChanges();
                        return "Success";
                    }

                    return "Fail";
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
