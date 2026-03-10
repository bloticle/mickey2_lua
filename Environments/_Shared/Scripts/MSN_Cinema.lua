MSN_CinemaPortal = function(location)
  Disable2DSetup("interior")
  SetGlobal("2dDirection", 99)
  SetGlobal("PlayerFirstTimeInZone", 1)
  SetGlobal("DEC_Hardload", false)
  EnableSplitScreen(true)
  RemoveAllMusicStateOverride()
  Print("Removing Cinema music state from MSN_CinemaPortal")
  if (location == "OsTown") then
    LoadLevel(GetPlayer(), "OST_Center.Main_Visit2")
  elseif (location == "RBC") then
    LoadLevel(GetPlayer(), "RBC_falls.Caverns_Angel_v2")
  elseif (location == "Gulch") then
    if (GetGlobal("FTL_Gulch_DepositedBalls") == 0) then
      LoadLevel(GetPlayer(), "FTL_Gulch.Canyon_v1")
    else
      LoadLevel(GetPlayer(), "FTL_Gulch.Canyon_v2")
      if (location == "DragonBoss_Start") then
        SetGlobal("FTL_Gulch_ProjectorExit", 3)
        wait(0)
        LoadLevel(GetPlayer(), "FTL_BlotworxDragon.SecondVisit")
      elseif (location == "DragonBoss_Alt") then
        SetGlobal("FTL_Gulch_ProjectorExit", 4)
        wait(0)
        LoadLevel(GetPlayer(), "FTL_BlotworxDragon.SecondVisit")
      elseif (location == "BogEasy") then
        if (GetGlobal("NOS_BogEasy_FirstVisit") == 0) then
          LoadLevel(GetPlayer(), "NOS_BogEasy.ShantyTown_V2")
        else
          LoadLevel(GetPlayer(), "NOS_BogEasy.ShantyTown_V1")
          if (location == "BlotAlley") then
            if (GetGlobal("FTL_Fort_SpatterState") ~= 10) then
              if (GetGlobal("FTL_Fort_SpatterState") ~= 1) then
                SetGlobal("NOS_BlotAlley_IanAngrySecondVisit", 1)
                if (GetGlobal("NOS_BlotAlley_Ian_2ndVisit_ThinSpatter_Played") == 0) then
                  SetGlobal("NOS_BlotAlley_IanAngrySecondVisit", 1)
                  LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_ian")
                else
                  LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_noian")
                  LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_ian")
                  LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit1")
                  if (location == "Train") then
                    if (GetGlobal("EM2_EpisodeCheck") < 3) then
                      LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV1")
                    else
                      LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV2")
                      if (location == "Fort") then
                        if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
                          LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
                        else
                          LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
                          if (location == "FloatGY") then
                            if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                            elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                            else
                              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                              if (location == "PrescottArena") then
                                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                              elseif (location == "Ventureland") then
                                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                                else
                                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                                  if (location == "Autotopia") then
                                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                          end
                                        else
                                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                          if (location == "Attic") then
                                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                              if (location == "NewRide") then
                                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                              end
                                            end
                                          elseif (location == "NewRide") then
                                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                          end
                                        end
                                      end
                                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                      end
                                    else
                                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                      if (location == "Attic") then
                                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                          if (location == "NewRide") then
                                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                          end
                                        end
                                      elseif (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "Autotopia") then
                                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                      end
                                    else
                                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                      if (location == "Attic") then
                                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                          if (location == "NewRide") then
                                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                          end
                                        end
                                      elseif (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  end
                                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "PrescottArena") then
                            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                          elseif (location == "Ventureland") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                            else
                              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                              if (location == "Autotopia") then
                                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                      end
                                    else
                                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                      if (location == "Attic") then
                                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                          if (location == "NewRide") then
                                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                          end
                                        end
                                      elseif (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  end
                                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "FloatGY") then
                        if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                        elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                        else
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                          if (location == "PrescottArena") then
                            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                          elseif (location == "Ventureland") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                            else
                              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                              if (location == "Autotopia") then
                                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                      end
                                    else
                                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                      if (location == "Attic") then
                                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                          if (location == "NewRide") then
                                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                          end
                                        end
                                      elseif (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  end
                                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Fort") then
                    if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
                      LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
                    else
                      LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
                      if (location == "FloatGY") then
                        if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                        elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                        else
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                          if (location == "PrescottArena") then
                            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                          elseif (location == "Ventureland") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                            else
                              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                              if (location == "Autotopia") then
                                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                      end
                                    else
                                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                      if (location == "Attic") then
                                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                          if (location == "NewRide") then
                                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                          end
                                        end
                                      elseif (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  end
                                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "FloatGY") then
                    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                    else
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                      if (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
              LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_ian")
            else
              LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit1")
              if (location == "Train") then
                if (GetGlobal("EM2_EpisodeCheck") < 3) then
                  LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV1")
                else
                  LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV2")
                  if (location == "Fort") then
                    if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
                      LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
                    else
                      LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
                      if (location == "FloatGY") then
                        if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                        elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                        else
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                          if (location == "PrescottArena") then
                            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                          elseif (location == "Ventureland") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                            else
                              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                              if (location == "Autotopia") then
                                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                      end
                                    else
                                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                      if (location == "Attic") then
                                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                          if (location == "NewRide") then
                                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                          end
                                        end
                                      elseif (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  end
                                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "FloatGY") then
                    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                    else
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                      if (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Fort") then
                if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
                  LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
                else
                  LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
                  if (location == "FloatGY") then
                    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                    else
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                      if (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "FloatGY") then
                if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                else
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                  if (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Train") then
            if (GetGlobal("EM2_EpisodeCheck") < 3) then
              LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV1")
            else
              LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV2")
              if (location == "Fort") then
                if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
                  LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
                else
                  LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
                  if (location == "FloatGY") then
                    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                    else
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                      if (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "FloatGY") then
                if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                else
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                  if (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Fort") then
            if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
              LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
            else
              LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
              if (location == "FloatGY") then
                if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                else
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                  if (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "FloatGY") then
            if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
            elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
            else
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
              if (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "BlotAlley") then
        if (GetGlobal("FTL_Fort_SpatterState") ~= 10) then
          if (GetGlobal("FTL_Fort_SpatterState") ~= 1) then
            SetGlobal("NOS_BlotAlley_IanAngrySecondVisit", 1)
            if (GetGlobal("NOS_BlotAlley_Ian_2ndVisit_ThinSpatter_Played") == 0) then
              SetGlobal("NOS_BlotAlley_IanAngrySecondVisit", 1)
              LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_ian")
            else
              LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_noian")
              LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_ian")
              LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit1")
              if (location == "Train") then
                if (GetGlobal("EM2_EpisodeCheck") < 3) then
                  LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV1")
                else
                  LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV2")
                  if (location == "Fort") then
                    if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
                      LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
                    else
                      LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
                      if (location == "FloatGY") then
                        if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                        elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                        else
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                          if (location == "PrescottArena") then
                            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                          elseif (location == "Ventureland") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                            else
                              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                              if (location == "Autotopia") then
                                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                      end
                                    else
                                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                      if (location == "Attic") then
                                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                          if (location == "NewRide") then
                                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                          end
                                        end
                                      elseif (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  end
                                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "FloatGY") then
                    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                    else
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                      if (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Fort") then
                if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
                  LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
                else
                  LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
                  if (location == "FloatGY") then
                    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                    else
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                      if (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "FloatGY") then
                if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                else
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                  if (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          end
          LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_ian")
        else
          LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit1")
          if (location == "Train") then
            if (GetGlobal("EM2_EpisodeCheck") < 3) then
              LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV1")
            else
              LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV2")
              if (location == "Fort") then
                if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
                  LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
                else
                  LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
                  if (location == "FloatGY") then
                    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                    else
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                      if (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "FloatGY") then
                if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                else
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                  if (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Fort") then
            if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
              LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
            else
              LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
              if (location == "FloatGY") then
                if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                else
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                  if (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "FloatGY") then
            if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
            elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
            else
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
              if (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Train") then
        if (GetGlobal("EM2_EpisodeCheck") < 3) then
          LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV1")
        else
          LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV2")
          if (location == "Fort") then
            if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
              LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
            else
              LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
              if (location == "FloatGY") then
                if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                else
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                  if (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "FloatGY") then
            if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
            elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
            else
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
              if (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Fort") then
        if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
          LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
        else
          LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
          if (location == "FloatGY") then
            if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
            elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
            else
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
              if (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "FloatGY") then
        if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
        elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
        else
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
          if (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "PrescottArena") then
        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
      elseif (location == "Ventureland") then
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
        else
          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
          if (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Autotopia") then
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          if (GetGlobal("Autotopia_Core_Progression") == 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
            if (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          end
        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
          if (GetGlobal("Autotopia_Core_Progression") < 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
          end
        else
          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
          if (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Attic") then
        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
          if (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "NewRide") then
        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
      end
    end
  elseif (location == "DragonBoss_Start") then
    SetGlobal("FTL_Gulch_ProjectorExit", 3)
    wait(0)
    LoadLevel(GetPlayer(), "FTL_BlotworxDragon.SecondVisit")
  elseif (location == "DragonBoss_Alt") then
    SetGlobal("FTL_Gulch_ProjectorExit", 4)
    wait(0)
    LoadLevel(GetPlayer(), "FTL_BlotworxDragon.SecondVisit")
  elseif (location == "BogEasy") then
    if (GetGlobal("NOS_BogEasy_FirstVisit") == 0) then
      LoadLevel(GetPlayer(), "NOS_BogEasy.ShantyTown_V2")
    else
      LoadLevel(GetPlayer(), "NOS_BogEasy.ShantyTown_V1")
      if (location == "BlotAlley") then
        if (GetGlobal("FTL_Fort_SpatterState") ~= 10) then
          if (GetGlobal("FTL_Fort_SpatterState") ~= 1) then
            SetGlobal("NOS_BlotAlley_IanAngrySecondVisit", 1)
            if (GetGlobal("NOS_BlotAlley_Ian_2ndVisit_ThinSpatter_Played") == 0) then
              SetGlobal("NOS_BlotAlley_IanAngrySecondVisit", 1)
              LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_ian")
            else
              LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_noian")
              LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_ian")
              LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit1")
              if (location == "Train") then
                if (GetGlobal("EM2_EpisodeCheck") < 3) then
                  LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV1")
                else
                  LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV2")
                  if (location == "Fort") then
                    if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
                      LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
                    else
                      LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
                      if (location == "FloatGY") then
                        if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                        elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                        else
                          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                          if (location == "PrescottArena") then
                            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                          elseif (location == "Ventureland") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                            else
                              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                              if (location == "Autotopia") then
                                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                      end
                                    else
                                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                      if (location == "Attic") then
                                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                          if (location == "NewRide") then
                                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                          end
                                        end
                                      elseif (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  end
                                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "FloatGY") then
                    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                    else
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                      if (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Fort") then
                if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
                  LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
                else
                  LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
                  if (location == "FloatGY") then
                    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                    else
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                      if (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "FloatGY") then
                if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                else
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                  if (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          end
          LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_ian")
        else
          LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit1")
          if (location == "Train") then
            if (GetGlobal("EM2_EpisodeCheck") < 3) then
              LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV1")
            else
              LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV2")
              if (location == "Fort") then
                if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
                  LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
                else
                  LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
                  if (location == "FloatGY") then
                    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                    else
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                      if (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "FloatGY") then
                if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                else
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                  if (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Fort") then
            if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
              LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
            else
              LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
              if (location == "FloatGY") then
                if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                else
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                  if (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "FloatGY") then
            if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
            elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
            else
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
              if (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Train") then
        if (GetGlobal("EM2_EpisodeCheck") < 3) then
          LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV1")
        else
          LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV2")
          if (location == "Fort") then
            if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
              LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
            else
              LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
              if (location == "FloatGY") then
                if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                else
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                  if (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "FloatGY") then
            if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
            elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
            else
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
              if (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Fort") then
        if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
          LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
        else
          LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
          if (location == "FloatGY") then
            if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
            elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
            else
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
              if (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "FloatGY") then
        if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
        elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
        else
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
          if (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "PrescottArena") then
        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
      elseif (location == "Ventureland") then
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
        else
          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
          if (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Autotopia") then
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          if (GetGlobal("Autotopia_Core_Progression") == 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
            if (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          end
        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
          if (GetGlobal("Autotopia_Core_Progression") < 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
          end
        else
          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
          if (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Attic") then
        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
          if (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "NewRide") then
        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
      end
    end
  elseif (location == "BlotAlley") then
    if (GetGlobal("FTL_Fort_SpatterState") ~= 10) then
      if (GetGlobal("FTL_Fort_SpatterState") ~= 1) then
        SetGlobal("NOS_BlotAlley_IanAngrySecondVisit", 1)
        if (GetGlobal("NOS_BlotAlley_Ian_2ndVisit_ThinSpatter_Played") == 0) then
          SetGlobal("NOS_BlotAlley_IanAngrySecondVisit", 1)
          LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_ian")
        else
          LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_noian")
          LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_ian")
          LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit1")
          if (location == "Train") then
            if (GetGlobal("EM2_EpisodeCheck") < 3) then
              LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV1")
            else
              LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV2")
              if (location == "Fort") then
                if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
                  LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
                else
                  LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
                  if (location == "FloatGY") then
                    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                    else
                      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                      if (location == "PrescottArena") then
                        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                      elseif (location == "Ventureland") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                        else
                          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                          if (location == "Autotopia") then
                            if (GetGlobal("EM2_EpisodeCheck") == 4) then
                              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                                  end
                                else
                                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                                  if (location == "Attic") then
                                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                      if (location == "NewRide") then
                                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                      end
                                    end
                                  elseif (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              end
                            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "FloatGY") then
                if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                else
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                  if (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Fort") then
            if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
              LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
            else
              LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
              if (location == "FloatGY") then
                if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                else
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                  if (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "FloatGY") then
            if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
            elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
            else
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
              if (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      end
      LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit2_ian")
    else
      LoadLevel(GetPlayer(), "nos_blotalley_main.section1_visit1")
      if (location == "Train") then
        if (GetGlobal("EM2_EpisodeCheck") < 3) then
          LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV1")
        else
          LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV2")
          if (location == "Fort") then
            if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
              LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
            else
              LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
              if (location == "FloatGY") then
                if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
                elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
                else
                  LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
                  if (location == "PrescottArena") then
                    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
                  elseif (location == "Ventureland") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                    else
                      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                      if (location == "Autotopia") then
                        if (GetGlobal("EM2_EpisodeCheck") == 4) then
                          if (GetGlobal("Autotopia_Core_Progression") == 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                            if (GetGlobal("EM2_EpisodeCheck") < 4) then
                              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                              end
                            else
                              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                              if (location == "Attic") then
                                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                                  if (location == "NewRide") then
                                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                                  end
                                end
                              elseif (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          end
                        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "FloatGY") then
            if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
            elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
            else
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
              if (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Fort") then
        if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
          LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
        else
          LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
          if (location == "FloatGY") then
            if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
            elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
            else
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
              if (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "FloatGY") then
        if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
        elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
        else
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
          if (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "PrescottArena") then
        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
      elseif (location == "Ventureland") then
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
        else
          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
          if (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Autotopia") then
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          if (GetGlobal("Autotopia_Core_Progression") == 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
            if (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          end
        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
          if (GetGlobal("Autotopia_Core_Progression") < 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
          end
        else
          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
          if (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Attic") then
        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
          if (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "NewRide") then
        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
      end
    end
  elseif (location == "Train") then
    if (GetGlobal("EM2_EpisodeCheck") < 3) then
      LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV1")
    else
      LoadLevel(GetPlayer(), "TRT_TrainTunnels.ClockV2")
      if (location == "Fort") then
        if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
          LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
        else
          LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
          if (location == "FloatGY") then
            if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
            elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
            else
              LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
              if (location == "PrescottArena") then
                LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
              elseif (location == "Ventureland") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
                else
                  LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
                  if (location == "Autotopia") then
                    if (GetGlobal("EM2_EpisodeCheck") == 4) then
                      if (GetGlobal("Autotopia_Core_Progression") == 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                        if (GetGlobal("EM2_EpisodeCheck") < 4) then
                          if (GetGlobal("Autotopia_Core_Progression") < 1) then
                            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                          end
                        else
                          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                          if (location == "Attic") then
                            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                              if (location == "NewRide") then
                                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                              end
                            end
                          elseif (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      end
                    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "FloatGY") then
        if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
        elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
        else
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
          if (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "PrescottArena") then
        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
      elseif (location == "Ventureland") then
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
        else
          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
          if (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Autotopia") then
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          if (GetGlobal("Autotopia_Core_Progression") == 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
            if (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          end
        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
          if (GetGlobal("Autotopia_Core_Progression") < 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
          end
        else
          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
          if (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Attic") then
        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
          if (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "NewRide") then
        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
      end
    end
  elseif (location == "Fort") then
    if (GetGlobal("FTL_Ian_BlotlingResolution_Played") == 0) then
      LoadLevel(GetPlayer(), "FTL_fort01a.V1_Docks_ALTrees")
    else
      LoadLevel(GetPlayer(), "FTL_fort01a.V2_Docks_ALTrees")
      if (location == "FloatGY") then
        if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
        elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
        else
          LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
          if (location == "PrescottArena") then
            LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
          elseif (location == "Ventureland") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
            else
              LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
              if (location == "Autotopia") then
                if (GetGlobal("EM2_EpisodeCheck") == 4) then
                  if (GetGlobal("Autotopia_Core_Progression") == 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
                  elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                    if (GetGlobal("EM2_EpisodeCheck") < 4) then
                      if (GetGlobal("Autotopia_Core_Progression") < 1) then
                        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                      end
                    else
                      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                      if (location == "Attic") then
                        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                          if (location == "NewRide") then
                            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                          end
                        end
                      elseif (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  end
                elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "PrescottArena") then
        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
      elseif (location == "Ventureland") then
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
        else
          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
          if (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Autotopia") then
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          if (GetGlobal("Autotopia_Core_Progression") == 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
            if (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          end
        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
          if (GetGlobal("Autotopia_Core_Progression") < 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
          end
        else
          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
          if (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Attic") then
        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
          if (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "NewRide") then
        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
      end
    end
  elseif (location == "FloatGY") then
    if (GetGlobal("FTL_FloatGraveyard_IntroIGC") == 0) then
      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_IGC")
    elseif (GetGlobal("FTL_FloatGraveyard_VisitNumber") == 1) then
      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v1")
    else
      LoadLevel(GetPlayer(), "FTL_FloatGraveyard.A2_v2")
      if (location == "PrescottArena") then
        LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
      elseif (location == "Ventureland") then
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
        else
          LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
          if (location == "Autotopia") then
            if (GetGlobal("EM2_EpisodeCheck") == 4) then
              if (GetGlobal("Autotopia_Core_Progression") == 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
              elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
              elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
                if (GetGlobal("EM2_EpisodeCheck") < 4) then
                  if (GetGlobal("Autotopia_Core_Progression") < 1) then
                    LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
                  end
                else
                  LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
                  if (location == "Attic") then
                    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                      if (location == "NewRide") then
                        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                      end
                    end
                  elseif (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              end
            elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Autotopia") then
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          if (GetGlobal("Autotopia_Core_Progression") == 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
            if (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          end
        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
          if (GetGlobal("Autotopia_Core_Progression") < 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
          end
        else
          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
          if (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Attic") then
        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
          if (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "NewRide") then
        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
      end
    end
  elseif (location == "PrescottArena") then
    LoadLevel(GetPlayer(), "FTL_PrescottsArena.OutsideV2")
  elseif (location == "Ventureland") then
    if (GetGlobal("EM2_EpisodeCheck") == 4) then
      LoadLevel(GetPlayer(), "VTL_Oasis.Main_EpilogueLoadin")
    else
      LoadLevel(GetPlayer(), "VTL_Oasis.Main_MainStoryLoadIn")
      if (location == "Autotopia") then
        if (GetGlobal("EM2_EpisodeCheck") == 4) then
          if (GetGlobal("Autotopia_Core_Progression") == 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
          elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
          elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
            if (GetGlobal("EM2_EpisodeCheck") < 4) then
              if (GetGlobal("Autotopia_Core_Progression") < 1) then
                LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
              end
            else
              LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
              if (location == "Attic") then
                if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
                elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
                  LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
                  if (location == "NewRide") then
                    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
                  end
                end
              elseif (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          end
        elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
          if (GetGlobal("Autotopia_Core_Progression") < 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
          end
        else
          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
          if (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "Attic") then
        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
          if (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "NewRide") then
        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
      end
    end
  elseif (location == "Autotopia") then
    if (GetGlobal("EM2_EpisodeCheck") == 4) then
      if (GetGlobal("Autotopia_Core_Progression") == 1) then
        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.Main_Visit2")
      elseif (GetGlobal("Autotopia_Core_Progression") == 2) then
        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_trial")
      elseif (GetGlobal("Autotopia_Core_Progression") == 3) then
        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_derby")
        if (GetGlobal("EM2_EpisodeCheck") < 4) then
          if (GetGlobal("Autotopia_Core_Progression") < 1) then
            LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
          end
        else
          LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
          if (location == "Attic") then
            if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
            elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
              LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
              if (location == "NewRide") then
                LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
              end
            end
          elseif (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      end
    elseif (GetGlobal("EM2_EpisodeCheck") < 4) then
      if (GetGlobal("Autotopia_Core_Progression") < 1) then
        LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionA_first")
      end
    else
      LoadLevel(GetPlayer(), "TCY_autotopia_visit1.SectionG_first")
      if (location == "Attic") then
        if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
        elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
          LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
          if (location == "NewRide") then
            LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
          end
        end
      elseif (location == "NewRide") then
        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
      end
    end
  elseif (location == "Attic") then
    if (GetGlobal("LMR_TheAttic_VisitNumber") == 1) then
      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_1")
    elseif (GetGlobal("LMR_TheAttic_VisitNumber") == 2) then
      LoadLevel(GetPlayer(), "LMR_MadDoctorAttic.Visit_2")
      if (location == "NewRide") then
        LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
      end
    end
  elseif (location == "NewRide") then
    LoadLevel(GetPlayer(), "MST_NewRide.SecVLower")
  end
  return 
end
MSN_CinemaPortal_PrescottArena02 = function()
  Disable2DSetup()
  LoadLevel(GetPlayer(), "FTL_PrescottsArena.Inside")
  return 
end

