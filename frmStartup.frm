VERSION 5.00
Begin VB.Form frmStartup 
   BorderStyle     =   0  'None
   Caption         =   "ϵͳ���̹���"
   ClientHeight    =   3195
   ClientLeft      =   150
   ClientTop       =   720
   ClientWidth     =   4680
   Icon            =   "frmStartup.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  '����ȱʡ
   Visible         =   0   'False
   Begin VB.Menu mnuSys 
      Caption         =   "ϵͳ�˵�"
      WindowList      =   -1  'True
      Begin VB.Menu mnuNewNote 
         Caption         =   "�½�һ����ǩ(&N)"
      End
      Begin VB.Menu mnuShowAllNote 
         Caption         =   "��ʾ���б�ǩ(&V)"
      End
      Begin VB.Menu mnuHideAllNote 
         Caption         =   "�������б�ǩ(&H)"
      End
      Begin VB.Menu line1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuRunStartup 
         Caption         =   "��Ϊ����������(&S)"
      End
      Begin VB.Menu line2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuHelp 
         Caption         =   "ʹ�ð���(&H)"
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "���� ΢��ǩ(&A)..."
      End
      Begin VB.Menu line3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "�˳�(&X)"
      End
   End
End
Attribute VB_Name = "frmStartup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'==============================================================================================
'��    �ƣ�΢��ǩ��WeNote
'��    ����΢��ǩ��һ��windows����ϵͳ�µı�ǩ��������ȫ�������ϵͳ�Դ��ı�㣬ÿ��
'          ��ǩ�ɵ����������ѣ������ð�͸������ǩƽ��������ϵͳ���½�����������ռ��
'          ��������ʹ�������ǳ����㡣����ʹ�÷������һ�ϵͳ���̲˵��鿴������
'��    �̣�sysdzw ԭ�������������Ա��������иĽ�����չ�뷢��һ��
'�������ڣ�2020-03-02
'��    �ͣ�https://blog.csdn.net/sysdzw
'�û��ֲ᣺https://www.kancloud.cn/sysdzw/clswindow/
'Email   ��sysdzw@163.com
'QQ      ��171977759
'��    ����V1.0 ����                                                           2020-02-20
'==============================================================================================Option Explicit
Dim isDealing As Boolean

Private Declare Function SetForegroundWindow Lib "user32" (ByVal hwnd As Long) As Long
 
Private Sub Form_Load()
    Icon_Add Me.hwnd, "΢��ǩ", Me.Icon, 0
    mnuRunStartup.Caption = IIf(isHasSetAutoRun(), "��Ϊ�ֶ�����(&S)", "��Ϊ����������(&S)")
End Sub

Private Sub mnuAbout_Click()
    MsgBox strInfo, vbInformation
End Sub

Public Sub mnuExit_Click()
    If isFormAllLoadCompleted Then
        Call Icon_Del(Me.hwnd, 0)
        
        Dim frm As Form
        Dim w As New clsWindow
        For Each frm In Forms
            If frm.Caption = "WeNote" Then
                Unload frm
            End If
        Next
        
        Unload Me
    Else
        MsgBox "��ȴ���ǩȫ����������ٲ����˳���", vbInformation
    End If
End Sub

Private Sub mnuHelp_Click()
    Dim strHelp$
    strHelp = "WeNote | ΢��ǩ V1.0 ʹ��˵����" & vbCrLf & vbCrLf & _
        "�������ο�win7ϵͳ�Դ���ǩ������������ϵͳ�Դ��ĺ��÷����Ҹ�ǿ������Ϊ����ʹ�÷�����" & vbCrLf & vbCrLf & _
        "��1���½���ǩ��������3�֣�a.ֱ��˫��exe�������ǰû�б�ǩ���Զ��½�һ����b.������б�ǩ�����Ͻ�+�½���c.�һ�ϵͳ����ѡ��˵����½�һ����ǩ��" & vbCrLf & vbCrLf & _
        "��2������͸���ȡ�˫����ǩ���������ã�������������������ϣ����͸���ȡ�������Ե�ǰ��ǩ��Ч��" & vbCrLf & vbCrLf & _
        "��3�����ñ�ǩ��ɫ��˫����ǩ���������ã������ѡ�е���ɫ�����û����ϲ���Ŀ��Ե�������ࡱ����ɫ�����ѡ��" & vbCrLf & vbCrLf & _
        "��4�����ô����ö���˫����ǩ���������ã���ѡ�����ֵ�ǰ��ǩ��ǰ����������Ե�ǰ��ǩ��Ч��" & vbCrLf & vbCrLf & _
        "��5�������������ѡ�˫����ǩ���������ã���ѡ���һ�������������ʱ�䵥λ�����硰5���������ӡ���������Ե�ǰ��ǩ��Ч��" & vbCrLf & vbCrLf & _
        "��6�����ÿ����������һ�ϵͳ����ͼ�꣬�������Ϊ������������������Ѿ����ù����ɡ��ֶ�������������������л�������ȫ����Ч��" & vbCrLf & vbCrLf & _
        "  �����������ϵQQ171977759����" & vbCrLf & vbCrLf & _
        "2020-02-20"
    MsgBox strHelp, vbInformation
End Sub


Private Sub mnuNewNote_Click()
    Dim frmNote As New frmNote
    Load frmNote
End Sub

Private Sub mnuRunStartup_Click()
    If mnuRunStartup.Caption = "��Ϊ�ֶ�����(&S)" Then
        Call cancelAutoRun
        mnuRunStartup.Caption = "��Ϊ����������(&S)"
    Else
        Call setAutoRun
        mnuRunStartup.Caption = "��Ϊ�ֶ�����(&S)"
    End If
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim lMsg As Single
    lMsg = X / Screen.TwipsPerPixelX

    lMsg = X / Screen.TwipsPerPixelX
    Select Case lMsg
    Case WM_RBUTTONUP
        SetForegroundWindow Me.hwnd
        PopupMenu mnuSys
    Case WM_LBUTTONDOWN
        mnuShowAllNote_Click
    End Select
End Sub

Private Sub mnuShowAllNote_Click()
    Dim frm As Form
    Dim w As New clsWindow
    For Each frm In Forms
        If frm.Caption = "WeNote" Then
            w.hwnd = frm.hwnd
            frm.Visible = True
            w.Focus
        End If
    Next
End Sub

Private Sub mnuHideAllNote_Click()
    Dim frm As Form
    Dim w As New clsWindow
    For Each frm In Forms
        If frm.Caption = "WeNote" Then
            w.hwnd = frm.hwnd
            w.Hide
        End If
    Next
End Sub